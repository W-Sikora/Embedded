/*
 * File:          my_controller.c
 * Date:          
 * Description:   
 * Author:        
 * Modifications: 
 */

/*
 * You may need to add include files like <webots/distance_sensor.h> or
 * <webots/differential_wheels.h>, etc.
 */
#include <webots/robot.h>
#include <webots/differential_wheels.h>
#include <webots/camera.h>


/*
 * You may want to add defines macro here.
 */
#define TIME_STEP 64
#define PROG 100
#define MAX_SPEED 6
/*
 * You should put some helper functions here
 */

/*
 * This is the main program.
 * The arguments of the main function can be specified by the
 * "controllerArgs" field of the Robot node
 */
int main(int argc, char **argv)
{
  /* necessary to initialize webots stuff */
  wb_robot_init();
  WbDeviceTag camera = wb_robot_get_device("camera");
  WbDeviceTag leftmotor = wb_robot_get_device("left wheel motor");
  WbDeviceTag rightmotor = wb_robot_get_device("right wheel motor");
  wb_camera_enable(camera, TIME_STEP);
  
  int height = wb_camera_get_height(camera);
  int width = wb_camera_get_width(camera);
  
  
  /*
   * You should declare here WbDeviceTag variables for storing
   * robot devices like this:
   *  WbDeviceTag my_sensor = wb_robot_get_device("my_sensor");
   *  WbDeviceTag my_actuator = wb_robot_get_device("my_actuator");
   */
  
  /* main loop */
  do {
  int x =0;
  int y=0;
  int r_sum = 0;
  int g_sum = 0;
    const unsigned char *image = wb_camera_get_image(camera);
    for (x=0; x<width; x++)
      for (y=0; y<height; y++) {
      int r = wb_camera_image_get_red(image, width, x, y);
      int g = wb_camera_image_get_green(image, width, x, y);
      int b = wb_camera_image_get_blue(image, width, x, y);
      if(r > g && r> b && r >=PROG) {
        r_sum++;
      } else if(g> r && g> b && g>=PROG) {
        g_sum++;
      }
    }
    if(r_sum > g_sum && r_sum > height * width * 0.4) {
      wb_differential_wheels_set_speed(-MAX_SPEED, -MAX_SPEED);
    } 
    else if (g_sum > r_sum && g_sum > height * width * 0.4) {
      wb_differential_wheels_set_speed(MAX_SPEED, MAX_SPEED);
    } else {
        wb_differential_wheels_set_speed(0,0);
    }
    //printf("red=%d, green=%d", r_sum, g_sum);
    
  /* 
     * Read the sensors :
     * Enter here functions to read sensor data, like:
     *  double val = wb_distance_sensor_get_value(my_sensor);
     */
    
    /* Process sensor data here */
    
    /*
     * Enter here functions to send actuator commands, like:
     * wb_differential_wheels_set_speed(100.0,100.0);
     */
    
    /* 
     * Perform a simulation step of 64 milliseconds
     * and leave the loop when the simulation is over
     */
  } while (wb_robot_step(TIME_STEP) != -1);
  
  /* Enter here exit cleanup code */
  
  /* Necessary to cleanup webots stuff */
  wb_robot_cleanup();
  
  return 0;
}
