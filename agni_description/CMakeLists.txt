cmake_minimum_required(VERSION 2.8.3)
project(agni_description)
find_package(catkin REQUIRED COMPONENTS urdf sr_description lwr_description pa10_7a_description pa10_7c_description schunk_description myrmex_description)
find_package(xacro 1.10 REQUIRED)
find_package(flobi_description)
include_directories(${Boost_INCLUDE_DIR} ${catkin_INCLUDE_DIRS})

catkin_package(
    DEPENDS
    CATKIN_DEPENDS urdf sr_description lwr_description pa10_7a_description pa10_7c_description schunk_description flobi_description myrmex_description xacro
    INCLUDE_DIRS
    LIBRARIES
)


xacro_add_xacro_file(robots/sfb.urdf.xacro INORDER)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
if(flobi_description_FOUND)
  xacro_add_xacro_file(robots/famula.urdf.xacro INORDER)
  list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
  xacro_add_xacro_file(robots/moveable_famula.urdf.xacro INORDER)
  list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
endif()

# sfb frame
xacro_add_xacro_file(robots/single.urdf.xacro robots/sfb_frame.urdf INORDER REMAP FRAME:=sfb)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# famula frame
xacro_add_xacro_file(robots/single.urdf.xacro robots/famula_frame.urdf INORDER REMAP FRAME:=famula)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/moveable_famula_frame.urdf INORDER REMAP FRAME:=moveable_famula)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right pa10
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_pa10.urdf INORDER REMAP CALIB:=sfb ARM:=pa10c PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_pa10.urdf INORDER REMAP CALIB:=sfb ARM:=pa10a PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/bimanual.urdf.xacro robots/pa10.urdf INORDER REMAP  FRAME:=sfb ARM_R:=pa10c ARM_L:=pa10a FLOBI:=0 TOOL_R:=- TOOL_L:=- SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
# left right kuka
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_kuka.urdf INORDER REMAP CALIB:=famula ARM:=kukaR PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_kuka.urdf INORDER REMAP CALIB:=famula ARM:=kukaL PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})           
xacro_add_xacro_file(robots/bimanual.urdf.xacro robots/kuka.urdf INORDER REMAP  FRAME:=famula ARM_R:=kukaR ARM_L:=kukaL FLOBI:=0 TOOL_R:=- TOOL_L:=- SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right lwr (no auto_on)
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_lwr.urdf INORDER REMAP CALIB:=famula ARM:=lwrR PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_lwr.urdf INORDER REMAP CALIB:=famula ARM:=lwrL PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right shadow motor hand
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_shadow_hand_motor_ubi.urdf INORDER REMAP TOOL:=shadow_motor_right PREFIX:=r PARENT:=-)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_shadow_hand_motor_ubi.urdf INORDER REMAP TOOL:=shadow_motor_left PREFIX:=l PARENT:=-)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right pa10 shadow_hand_motor_ubi
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_pa10_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=sfb ARM:=pa10c TOOL:=shadow_motor_right PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_pa10_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=sfb ARM:=pa10a TOOL:=shadow_motor_left PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right kuka shadow_hand_motor_ubi
xacro_add_xacro_file(robots/single.urdf.xacro robots/right_kuka_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=famula ARM:=kukaR TOOL:=shadow_motor_right PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/left_kuka_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=famula ARM:=kukaL TOOL:=shadow_motor_left PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})

# left right kuka shadow_hand_motor_ubi moveable platform
xacro_add_xacro_file(robots/single.urdf.xacro robots/moveable_right_lwr_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=moveable_famula ARM:=lwrR TOOL:=shadow_motor_right PREFIX:=r SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})
xacro_add_xacro_file(robots/single.urdf.xacro robots/moveable_left_lwr_shadow_hand_motor_ubi.urdf INORDER REMAP CALIB:=moveable_famula ARM:=lwrL TOOL:=shadow_motor_left PREFIX:=l SIM:=1)
list(APPEND xacro_outputs ${XACRO_OUTPUT_FILE})


# install the generated files
xacro_install(xacro ${xacro_outputs} DESTINATION robots)


install(DIRECTORY doc/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/doc)

install(DIRECTORY kuka/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/kuka)

install(DIRECTORY shadow/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/shadow)
   
install(DIRECTORY schunk/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/schunk)

install(DIRECTORY pa10/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/pa10)

install(DIRECTORY urdf/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/urdf)

install(DIRECTORY models/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/models)

install(DIRECTORY config/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/config)

install(DIRECTORY calibration/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/calibration)

install(DIRECTORY robots/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/robots)

install(DIRECTORY launch/
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch)

# testing
enable_testing()
foreach(arm - pa10a pa10c kukaL kukaR)
  foreach(tool - shadow_motor_left shadow_motor_right shadow_muscle_left shadow_muscle_right schunk_hand_right schunk_hand_left myrmex poking_stick_ubi poking_stick_rigid)
    add_test(
      NAME test-${arm}-${tool}
      COMMAND ${CATKIN_ENV} ${_xacro_py} -o /dev/null --inorder ${CMAKE_CURRENT_SOURCE_DIR}/robots/single.urdf.xacro ARM:=${arm} TOOL:=${tool})
  endforeach()
endforeach()
