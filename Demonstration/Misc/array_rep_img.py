import numpy as np
import cv2
import matplotlib.pyplot as plt
import math

img = cv2.imread("./resource/download.jpeg", 1)
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
new_img = np.copy(img)
new_img.fill(0)
print(img.shape)
print(img[0][0])

plt.imshow(img)

# # use set_position
# ax = plt.gca()
# ax.spines['top'].set_color('none')
# ax.spines['left'].set_position('zero')
# ax.spines['right'].set_color('none')
# ax.spines['bottom'].set_position('zero')

plt.show()

for x in range(img.shape[0]):
    for y in range(img.shape[1]):
        print([x, y], "---->", [x - round(245/2), y + round(255/2)])


# cv2.imshow("image", img)
#
# cv2.waitKey(0)
# cv2.destroyAllWindows()


#
# def new_cordinates(u, v, img):
#     u, v = u + round(img.shape[1] / 2), v - round(img.shape[0] / 2)
#     r = (u ** 2 - v ** 2) ** (1 / 2)
#
#     if r == 0:
#         return (0, 0)
#
#     beta = 4.3 * math.pi / img.shape[1]
#
#     r_dash = (1 / beta) * (2 * (1 - beta * r * math.e ** (-beta * r) -
#                                 math.e ** (-beta * r))) ** 0.5
#
#     return (r_dash / r * u + round(img.shape[1] / 2) , r_dash / r * v -
#             round(img.shape[0] / 2))
#
#
# lst = []
# for i in range(img.shape[0]):
#     for j in range(img.shape[1]):
#         lst.append(new_cordinates(j, i, img))
