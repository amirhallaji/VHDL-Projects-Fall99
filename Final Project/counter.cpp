#include "HLS/hls.h"
#include <stdio.h>
#include "HLS/math.h"

using namespace ihc;

struct BMP {
    int width;
    int height;
    unsigned char header[54];
    unsigned char *pixels;
    int size;
};


component int rotate(BMP image, double degree) {
    static BMP newImage = image;
    static unsigned char pixels[256];
	
	static double M_PI = 3.14;

    static double radians = (degree * M_PI) / 180;
    static int sinf = (int) sin(radians);
    static int cosf = (int) cos(radians);

    static double x0 = 0.5 * (image.width - 1);     // point to rotate about
    static double y0 = 0.5 * (image.height - 1);     // center of image

    // rotation
    for (int x = 0; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
            long double a = x - x0;
            long double b = y - y0;
            int xx = (int) (+a * cosf - b * sinf + x0);
            int yy = (int) (+a * sinf + b * cosf + y0);

            if (xx >= 0 && xx < image.width && yy >= 0 && yy < image.height) {
                pixels[(y * image.height + x) * 3 + 0] = image.pixels[(yy * image.height + xx) * 3 + 0];
                pixels[(y * image.height + x) * 3 + 1] = image.pixels[(yy * image.height + xx) * 3 + 1];
                pixels[(y * image.height + x) * 3 + 2] = image.pixels[(yy * image.height + xx) * 3 + 2];
            }
        }
    }
    newImage.pixels = pixels;
    return 0;
}

int main() {
  
  return 0;

}

