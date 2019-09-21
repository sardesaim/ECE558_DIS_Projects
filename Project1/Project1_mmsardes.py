import numpy as np 
import matplotlib.pyplot as plt 
#from PIL import Image
import cv2

wolves = np.array([])
wolves = plt.imread('wolves.png')
plt.imshow(wolves)
wolves_grey = cv2.cvtColor(wolves, cv2.COLOR_BGR2GRAY);
plt.figure()
plt.imshow(wolves_grey)
#cv2.calcHist(wolves, 0, None, [256], [0,256])
