struct BMP {
    int width;
    int height;
    unsigned char header[54];
    unsigned char *pixels;
    int size;
};


void writeBMP(string filename, BMP image) {
    string fileName = "Output Files/" + filename;
    FILE *out = fopen(fileName.c_str(), "wb");
    fwrite(image.header, sizeof(unsigned char), 54, out);
    int i;
    unsigned char tmp;
    for (i = 0; i < image.size; i += 3) {
        tmp = image.pixels[i];
        image.pixels[i] = image.pixels[i + 2];
        image.pixels[i + 2] = tmp;
    }
    fwrite(image.pixels, sizeof(unsigned char), image.size, out); // read the rest of the data at once
    fclose(out);
}

BMP readBMP(string filename) {
    BMP image;
    int i;
    string fileName = "Input Files/" + filename;
    FILE *f = fopen(fileName.c_str(), "rb");
    fread(image.header, sizeof(unsigned char), 54, f); // read the 54-byte header

    // extract image height and width from header
    image.width = *(int *) &image.header[18];
    image.height = *(int *) &image.header[22];

    image.size = 3 * image.width * image.height;
    image.pixels = new unsigned char[image.size]; // allocate 3 bytes per pixel
    fread(image.pixels, sizeof(unsigned char), image.size, f); // read the rest of the data at once
    fclose(f);

    for (i = 0; i < image.size; i += 3) {
        unsigned char tmp = image.pixels[i];
        image.pixels[i] = image.pixels[i + 2];
        image.pixels[i + 2] = tmp;
    }
    return image;
}


BMP rotate(BMP image, double degree) {
    BMP newImage = image;
    unsigned char *pixels = new unsigned char[image.size];

    double radians = (degree * M_PI) / 180;
    int sinf = (int) sin(radians);
    int cosf = (int) cos(radians);

    double x0 = 0.5 * (image.width - 1);     // point to rotate about
    double y0 = 0.5 * (image.height - 1);     // center of image

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
    return newImage;
}

MAIN:

int main() {
    BMP image = readBMP("InImage_2.bmp");
    image = rotate(image,180);
    writeBMP("Output-11.bmp", image);
    return 0;
}
