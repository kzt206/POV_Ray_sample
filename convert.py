import cv2
import matplotlib.pyplot as plt
import numpy as np

for i in range(1, 14):
    file = 'disc{0}.png'.format(format(i, '02'))
    img = cv2.imread(file)
    convert_img = np.zeros((img.shape[0], img.shape[1], 4), dtype='uint8')
    blue = img[:, :, 0]
    green = img[:, :, 1]
    alpha = 255 - (green - blue)
    alpha[green <= blue] = 255
    alpha[alpha < 20] = 0
    convert_img[:, :, 0] = blue * np.divide(255 * np.ones(alpha.shape, dtype='float'), 
          alpha.astype(np.float), 
          out=np.zeros_like(alpha, dtype='float'), 
          where=alpha!=0)
    convert_img[:, :, 1] = convert_img[:, :, 0]
    convert_img[:, :, 2] = convert_img[:, :, 0]
    convert_img[:, :, 3] = alpha
    cv2.imwrite('cvt' + file, convert_img)
