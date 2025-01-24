import numpy

# DMA to grab, no copy, dont use pixel per class, use pointer to change adress

# unformated value, use binary form, how to image manipulation, read-write,
# ASCII, OD (linux convert binary form to display terminal)

# DMA, embedded system for real time image manipulation, a-b buffer, parallel
# programming, data contention ( softwre and hardwre), parallel programming
# in verilog, PFGA image grabber, omnivision real time image processing
# tutorials

# grab immage into DMA, a-b buffer

class Pixel:
    def __int__(self, RGBValue, location):
        self.RGBvalue = RGBValue
        self.location = location

    def getlocation(self):
        return self.location

    def getRGBvlaue(self):
        return self.RGBvalue


class Image:
    def __int__(self, img):
        img_copy = []
        for row in img:
            img_copy.append(list(map(Pixel, row)))
        self.img = img_copy
        self.new_img = numpy.ndarray([img.shape[0], img.shape[1]])
