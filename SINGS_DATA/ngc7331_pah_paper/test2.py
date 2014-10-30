import pylab
import numpy
import pyfits
import scipy.ndimage as ndimage




img = "mpf_6_2_strength_trim.fits"
image = pyfits.getdata(img, 0)
header = pyfits.getheader(img, 0)
pa = header['PA_RQST']
image = ndimage.rotate(image, pa)
fig = pylab.figure()
ax = pylab.subplot(1,3,1)
im = pylab.imshow(image,vmin=10.**(-7.),interpolation="nearest")

#img2 = "mpf_7_7_strength_trim.fits"
#image2 = pyfits.getdata(img2, 0)
#header2 = pyfits.getheader(img2, 0)
#pa2 = header2['PA_RQST']
#image2 = ndimage.rotate(image, pa)
#fig2 = pylab.figure()
#ax2 = pylab.subplot(1,3,1)
#im2 = pylab.imshow(image2,vmin=10.**(-7),interpolation="nearest")


#pylab.colorbar(im2,ax=ax2)
pylab.xlabel("x-ax")
pylab.ylabel("y-ax")

pylab.savefig("test2.ps")
