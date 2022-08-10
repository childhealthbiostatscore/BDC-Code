import cv2
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from PIL import Image
# file = "/Users/timvigers/Documents/Work/Sarit Polsky/PICLS/Data_Clean/PDFs/108A interim glucose download.4.28.2020.pdf"

# # Convert to JPEG
# pages = convert_from_path(file)
# for page in pages:
#     page.save("page_image.jpeg", "jpeg")

# reading image
img = cv2.imread('/Users/timvigers/page_image.jpeg')

# converting image into grayscale image
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# setting threshold of gray image
_, threshold = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY)

# using a findContours() function
contours, _ = cv2.findContours(
    threshold, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

i = 0

# list for storing names of shapes
for contour in contours:

    # here we are ignoring first counter because
    # findcontour function detects whole image as shape
    if i == 0:
        i = 1
        continue

    # cv2.approxPloyDP() function to approximate the shape
    approx = cv2.approxPolyDP(
        contour, 0.1*cv2.arcLength(contour, True), True)

    # using drawContours() function
    if len(approx) == 4:
        cv2.drawContours(img, [contour], 0, (0, 0, 255), 5)

# displaying the image after drawing contours
cv2.imshow('shapes', img)

cv2.waitKey(0)
cv2.destroyAllWindows()


im = Image.open('/Users/timvigers/page_image.jpeg')
width, height = im.size
pixel_values = list(im.getdata())
pixel_values = np.array(pixel_values).reshape((width, height, 3))
(96, 79, 191) in set(pixel_values)
