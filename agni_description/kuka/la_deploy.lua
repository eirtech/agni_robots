require "rttlib"
require "rttros"

tc=rtt.getTC()
d=tc:getPeer("Deployer")

-- ROS integration
d:import("rtt_rosnode")
d:import("rtt_roscomm")
d:import("rtt_std_msgs")
d:import("rtt_sensor_msgs")
d:import("rtt_diagnostic_msgs")
d:import("rtt_control_msgs")

-- Start of user code imports
d:import("s_motion_manager")
d:import("s_log_saver")
d:import("gazebo_attach_controller")


local pathOfThisFile = ...
print("path of this file :"..pathOfThisFile)

package.path = pathOfThisFile..'/kuka/?.lua;' .. package.path 

d:loadComponent("Grasp", "GazeboAttachController")
d:setActivity("Grasp", 0, 20, rtt.globals.ORO_SCHED_RT)
Grasp = d:getPeer("Grasp")

d:loadComponent("LogLA", "SLogSaver")
d:setActivity("LogLA", 0, 20, rtt.globals.ORO_SCHED_RT)
LogLA = d:getPeer("LogLA")
LogLA:configure()

d:loadComponent("MotionManager", "SMotionManager")
d:setActivity("MotionManager", 0.001, 60, rtt.globals.ORO_SCHED_RT)
MotionManager = d:getPeer("MotionManager")
MotionManager:configure()

require("kuka")
la_kuka = KukaControllers.create("la",49940)
la_kuka:init(d)
la_kuka:deploy(d)
la_kuka:connectIn(d,"FilteredJointPosition","MotionManager.DesiredJointPosLA")
la_kuka:connectOut(d,"JointPosition","MotionManager.FRIRealJointPosLA")
la_kuka:connectOut(d,"Log","LogLA.Log")


-- ROS in out
ros=rtt.provides("ros")
d:stream("Grasp.Attach",ros:topic("/gazebo_attach"))
d:stream("Grasp.Attached",ros:topic("/gazebo_attached"))


la_kuka:start()
LogLA:start()
MotionManager:start()

print("finished starting")
