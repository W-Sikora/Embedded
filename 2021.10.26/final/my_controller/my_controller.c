/*
 * You may need to add include files like <webots/distance_sensor.h> or
 * <webots/motor.h>, etc.
 */
#include <webots/robot.h>
#include <webots/camera.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
// #include <webots/differential_wheels.h>

#define TIME_STEP 64

//Pięć hiperparametrów 
//prog to ile musi byc czerwonego lub zielonego zeby bylo liczone
#define prog 100
//percentage to ile ekranu musi byc zeby uznac to za kulkę 
#define percentage 0.2
//tolerancja to ile moze byc roznicy w kolorze pomiedzy lewa a praw strona ekranu
#define tolerancja 1200
//predkosc obrotu nazwa mowi za siebie, im wieksza tym trudniej mu ustawic kulke w srodku
#define predkosc_obrotu 1.0
//predkosc jazdy 
#define predkosc_jazdy 6.0
/*
 * You may want to add macros here.
 */
/*
 * This is the main program.
 * The arguments of the main function can be specified by the
 * "controllerArgs" field of the Robot node
 */
int main(int argc, char **argv) {
  /* necessary to initialize webots stuff */
  wb_robot_init();

  WbDeviceTag camera = wb_robot_get_device("camera");
  wb_camera_enable(camera, TIME_STEP);

  WbDeviceTag left_motor, right_motor;
  left_motor = wb_robot_get_device("left wheel motor");
  right_motor = wb_robot_get_device("right wheel motor");
  wb_motor_set_position(left_motor, INFINITY);
  wb_motor_set_position(right_motor, INFINITY);
  wb_motor_set_velocity(left_motor, 0.0);
  wb_motor_set_velocity(right_motor, 0.0);

  /* main loop
   * Perform simulation steps of TIME_STEP milliseconds
   * and leave the loop when the simulation is over
   */
  while (wb_robot_step(TIME_STEP) != -1) {
   
    int image_width = wb_camera_get_width(camera);
    int image_height = wb_camera_get_height(camera);
    const unsigned char *image = wb_camera_get_image(camera);
    
    int r_suma_l = 0;
    int g_suma_l = 0;
    int r_suma_p = 0;
    int g_suma_p = 0;
    
    for (int x = 0; x < image_width/2; x++) {
      for (int y = 0; y < image_height; y++) {
        int r = wb_camera_image_get_red(image, image_width, x, y);
        int g = wb_camera_image_get_green(image, image_width, x, y);
        int b = wb_camera_image_get_blue(image, image_width, x, y);
        if (r>g && r>b && r>prog) {
          r_suma_l += r;
        }
        else if (g>r && g>b && g>prog) {
          g_suma_l += g;
        };
      };
    };
    
    
    for (int x = image_width/2; x < image_width; x++) {
      for (int y = 0; y < image_height; y++) {
        int r = wb_camera_image_get_red(image, image_width, x, y);
        int g = wb_camera_image_get_green(image, image_width, x, y);
        int b = wb_camera_image_get_blue(image, image_width, x, y);
        if (r>g && r>b && r>prog) {
          r_suma_p += r;
        }
        else if (g>r && g>b && g>prog) {
          g_suma_p += g;
        };
      };
    };
    
    printf("red_l=%d, green_l=%d, red_p=%d, green_p=%d\n", r_suma_l, g_suma_l, r_suma_p, g_suma_p);
    int piksele = image_height * image_width;
    int etap = 0;
    
    switch (etap) 
    {
      case 0:
        if ((abs(r_suma_p-r_suma_l)>tolerancja && r_suma_p > r_suma_l) || (abs(g_suma_p-g_suma_l)>tolerancja && g_suma_p > g_suma_l)) {
          wb_motor_set_velocity(left_motor, predkosc_obrotu);
          wb_motor_set_velocity(right_motor, -predkosc_obrotu);
          printf("skrecam w prawo\n");
          break;
          etap = 1;
        }
        else if ((abs(r_suma_l-r_suma_p)>tolerancja && r_suma_p < r_suma_l) || (abs(g_suma_l-g_suma_p)>tolerancja && g_suma_p < g_suma_l)) {
          wb_motor_set_velocity(right_motor, predkosc_obrotu);
          wb_motor_set_velocity(left_motor, -predkosc_obrotu);
          printf("skrecam w lewo\n");
          break;
          etap = 1;
        }
        else {
          printf("Nie skrecam!!!!!!!!\n");
          wb_motor_set_velocity(left_motor, 0.0);
          wb_motor_set_velocity(right_motor, 0.0);
          etap = 1;
        };

      case 1:
        if ((r_suma_l+r_suma_p)>(percentage*piksele)) {
          printf("--------------\n");
          wb_motor_set_velocity(left_motor, -predkosc_jazdy);
          wb_motor_set_velocity(right_motor, -predkosc_jazdy);
          etap = 0;
        }
        else if ((g_suma_l+g_suma_p)>(percentage*piksele)) {
          printf(".........................\n");
          wb_motor_set_velocity(left_motor, predkosc_jazdy);
          wb_motor_set_velocity(right_motor, predkosc_jazdy); 
          etap = 0;         
        }
        break;
    }
  };

  wb_robot_cleanup();

  return 0;
}
