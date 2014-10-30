import pylab
import numpy
import pyfits
import scipy.ndimage as ndimage

img = "main_pah_feature_6_2_strength.fits"
image = pyfits.getdata(img, 0)[:,42:72]
header = pyfits.getheader(img, 0)
#pa = header['PA_RQST']
#image = ndimage.rotate(image, pa)
fig = pylab.figure()


ax = pylab.subplot(1,2,1)
im = pylab.imshow(image,vmin=10.**(-7.),interpolation="nearest")
ax2 = pylab.subplot(1,2,2)
header = pyfits.getheader(img, 0)
#pa = header['PA_RQST']
img2 = "main_pah_feature_7_7_strength.fits"
image2 = pyfits.getdata(img2, 0)[:,42:72]


#image2 = ndimage.rotate(image, pa)
im2 = pylab.imshow(image2,vmin=10.**(-7.),interpolation="nearest")

ax = pylab.subplot(1,3,1)
im = pylab.imshow(image,vmin=10.**(-7.),interpolation="nearest")
ax2 = pylab.subplot(1,3,2)
im3 = "main_pah_feature_11_3_strength.fits"
image3 = pyfits.getdata(img, 0)[:,42:72]
header = pyfits.getheader(img, 0)
#pa = header['PA_RQST']
#image = ndimage.rotate(image3, pa)
im3 = pylab.imshow(image3,vmin=10.**(-7.),interpolation="nearest")

#pylab.colorbar(im2,ax=ax2)
pylab.xlabel("x-ax")
pylab.ylabel("y-ax")

pylab.savefig("test.png")
