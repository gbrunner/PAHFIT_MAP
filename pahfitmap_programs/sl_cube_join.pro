;SL_CUBE_JOIN.PRO is a brute force means to concatonate SL1 and SL2
;data cubes created in CUBISM.  It is used to grid the SL2 data cube to the 
;SL1 data cube so that they can be more convieniently used in 
;SL_PAHFIT_MAP.PRO

;SL_CUBE_JOIN.PRO has been succesfully tested on various SINGS DR4 
;data cubes.  

;PURPOSE
;concatonate SL1 and SL2 data cubes into one SL data cubes.  
;Makes sure that the astronometry is correct and that both cubes 
;are on the same grid

;PROCEDURE:

;EXAMPLE:
; sl_cube_join, 'ngc0337_DR4_SL1_cube.fits', 'ngc0337_DR4_SL2_cube.fits',
;'sl_cube.fits'

;NEED TO ADD TO PROGRAM:  
;1. Crop the data cube 
;2. Use a loop instead of rendering every plane as an image


pro sl_cube_join, sl1_cube, sl2_cube, sl_output

sl1_cube = readfits(sl1_cube, sl1_cube_header)
sl2_cube = readfits(sl2_cube, sl2_cube_header)

sxaddpar, sl1_cube_header, 'NAXIS', 2
sxaddpar, sl2_cube_header, 'NAXIS', 2

sxdelpar, sl1_cube_header, 'NAXIS3'
sxdelpar, sl2_cube_header, 'NAXIS3'

sl2_image0 = sl2_cube(*,*,0)
sl2_image1 = sl2_cube(*,*,1)
sl2_image2 = sl2_cube(*,*,2)
sl2_image3 = sl2_cube(*,*,3)
sl2_image4 = sl2_cube(*,*,4)
sl2_image5 = sl2_cube(*,*,5)
sl2_image6 = sl2_cube(*,*,6)
sl2_image7 = sl2_cube(*,*,7)
sl2_image8 = sl2_cube(*,*,8)
sl2_image9 = sl2_cube(*,*,9)
sl2_image10 = sl2_cube(*,*,10)
sl2_image11 = sl2_cube(*,*,11)
sl2_image12 = sl2_cube(*,*,12)
sl2_image13 = sl2_cube(*,*,13)
sl2_image14 = sl2_cube(*,*,14)
sl2_image15 = sl2_cube(*,*,15)
sl2_image16 = sl2_cube(*,*,16)
sl2_image17 = sl2_cube(*,*,17)
sl2_image18 = sl2_cube(*,*,18)
sl2_image19 = sl2_cube(*,*,19)
sl2_image20 = sl2_cube(*,*,20)
sl2_image21 = sl2_cube(*,*,21)
sl2_image22 = sl2_cube(*,*,22)
sl2_image23 = sl2_cube(*,*,23)
sl2_image24 = sl2_cube(*,*,24)
sl2_image25 = sl2_cube(*,*,25)
sl2_image26 = sl2_cube(*,*,26)
sl2_image27 = sl2_cube(*,*,27)
sl2_image28 = sl2_cube(*,*,28)
sl2_image29 = sl2_cube(*,*,29)
sl2_image30 = sl2_cube(*,*,30)
sl2_image31 = sl2_cube(*,*,31)
sl2_image32 = sl2_cube(*,*,32)
sl2_image33 = sl2_cube(*,*,33)
sl2_image34 = sl2_cube(*,*,34)
sl2_image35 = sl2_cube(*,*,35)
sl2_image36 = sl2_cube(*,*,36)
sl2_image37 = sl2_cube(*,*,37)
sl2_image38 = sl2_cube(*,*,38)
sl2_image39 = sl2_cube(*,*,39)
sl2_image40 = sl2_cube(*,*,40)
sl2_image41 = sl2_cube(*,*,41)
sl2_image42 = sl2_cube(*,*,42)
sl2_image43 = sl2_cube(*,*,43)
sl2_image44 = sl2_cube(*,*,44)
sl2_image45 = sl2_cube(*,*,45)
sl2_image46 = sl2_cube(*,*,46)
sl2_image47 = sl2_cube(*,*,47)
sl2_image48 = sl2_cube(*,*,48)
sl2_image49 = sl2_cube(*,*,49)
sl2_image50 = sl2_cube(*,*,50)
sl2_image51 = sl2_cube(*,*,51)
sl2_image52 = sl2_cube(*,*,52)
sl2_image53 = sl2_cube(*,*,53)
sl2_image54 = sl2_cube(*,*,54)
sl2_image55 = sl2_cube(*,*,55)
sl2_image56 = sl2_cube(*,*,56)
sl2_image57 = sl2_cube(*,*,57)
sl2_image58 = sl2_cube(*,*,58)
sl2_image59 = sl2_cube(*,*,59)
sl2_image60 = sl2_cube(*,*,60)
sl2_image61 = sl2_cube(*,*,61)
sl2_image62 = sl2_cube(*,*,62)
sl2_image63 = sl2_cube(*,*,63)
sl2_image64 = sl2_cube(*,*,64)
sl2_image65 = sl2_cube(*,*,65)
sl2_image66 = sl2_cube(*,*,66)
sl2_image67 = sl2_cube(*,*,67)
sl2_image68 = sl2_cube(*,*,68)
sl2_image69 = sl2_cube(*,*,69)
sl2_image70 = sl2_cube(*,*,70)
sl2_image71 = sl2_cube(*,*,71)
sl2_image72 = sl2_cube(*,*,72)
sl2_image73 = sl2_cube(*,*,73)
sl2_image74 = sl2_cube(*,*,74)
sl2_image75 = sl2_cube(*,*,75)
sl2_image76 = sl2_cube(*,*,76)

sl2_cube_header0 = sl2_cube_header
sl2_cube_header1 = sl2_cube_header
sl2_cube_header2 = sl2_cube_header
sl2_cube_header3 = sl2_cube_header
sl2_cube_header4 = sl2_cube_header
sl2_cube_header5 = sl2_cube_header
sl2_cube_header6 = sl2_cube_header
sl2_cube_header7 = sl2_cube_header
sl2_cube_header8 = sl2_cube_header
sl2_cube_header9 = sl2_cube_header
sl2_cube_header10 = sl2_cube_header
sl2_cube_header11 = sl2_cube_header
sl2_cube_header12 = sl2_cube_header
sl2_cube_header13 = sl2_cube_header
sl2_cube_header14 = sl2_cube_header
sl2_cube_header15 = sl2_cube_header
sl2_cube_header16 = sl2_cube_header
sl2_cube_header17 = sl2_cube_header
sl2_cube_header18 = sl2_cube_header
sl2_cube_header19 = sl2_cube_header
sl2_cube_header20 = sl2_cube_header
sl2_cube_header21 = sl2_cube_header
sl2_cube_header22 = sl2_cube_header
sl2_cube_header23 = sl2_cube_header
sl2_cube_header24 = sl2_cube_header
sl2_cube_header25 = sl2_cube_header
sl2_cube_header26 = sl2_cube_header
sl2_cube_header27 = sl2_cube_header
sl2_cube_header28 = sl2_cube_header
sl2_cube_header29 = sl2_cube_header
sl2_cube_header30 = sl2_cube_header
sl2_cube_header31 = sl2_cube_header
sl2_cube_header32 = sl2_cube_header
sl2_cube_header33 = sl2_cube_header
sl2_cube_header34 = sl2_cube_header
sl2_cube_header35 = sl2_cube_header
sl2_cube_header36 = sl2_cube_header
sl2_cube_header37 = sl2_cube_header
sl2_cube_header38 = sl2_cube_header
sl2_cube_header39 = sl2_cube_header
sl2_cube_header40 = sl2_cube_header
sl2_cube_header41 = sl2_cube_header
sl2_cube_header42 = sl2_cube_header
sl2_cube_header43 = sl2_cube_header
sl2_cube_header44 = sl2_cube_header
sl2_cube_header45 = sl2_cube_header
sl2_cube_header46 = sl2_cube_header
sl2_cube_header47 = sl2_cube_header
sl2_cube_header48 = sl2_cube_header
sl2_cube_header49 = sl2_cube_header
sl2_cube_header50 = sl2_cube_header
sl2_cube_header51 = sl2_cube_header
sl2_cube_header52 = sl2_cube_header
sl2_cube_header53 = sl2_cube_header
sl2_cube_header54 = sl2_cube_header
sl2_cube_header55 = sl2_cube_header
sl2_cube_header56 = sl2_cube_header
sl2_cube_header57 = sl2_cube_header
sl2_cube_header58 = sl2_cube_header
sl2_cube_header59 = sl2_cube_header
sl2_cube_header60 = sl2_cube_header
sl2_cube_header61 = sl2_cube_header
sl2_cube_header62 = sl2_cube_header
sl2_cube_header63 = sl2_cube_header
sl2_cube_header64 = sl2_cube_header
sl2_cube_header65 = sl2_cube_header
sl2_cube_header66 = sl2_cube_header
sl2_cube_header67 = sl2_cube_header
sl2_cube_header68 = sl2_cube_header
sl2_cube_header69 = sl2_cube_header
sl2_cube_header70 = sl2_cube_header
sl2_cube_header71 = sl2_cube_header
sl2_cube_header72 = sl2_cube_header
sl2_cube_header73 = sl2_cube_header
sl2_cube_header74 = sl2_cube_header
sl2_cube_header75 = sl2_cube_header
sl2_cube_header76 = sl2_cube_header


sl1_image0 = sl1_cube(*,*,0)
sl1_image1 = sl1_cube(*,*,1)
sl1_image2 = sl1_cube(*,*,2)
sl1_image3 = sl1_cube(*,*,3)
sl1_image4 = sl1_cube(*,*,4)
sl1_image5 = sl1_cube(*,*,5)
sl1_image6 = sl1_cube(*,*,6)
sl1_image7 = sl1_cube(*,*,7)
sl1_image8 = sl1_cube(*,*,8)
sl1_image9 = sl1_cube(*,*,9)
sl1_image10 = sl1_cube(*,*,10)
sl1_image11 = sl1_cube(*,*,11)
sl1_image12 = sl1_cube(*,*,12)
sl1_image13 = sl1_cube(*,*,13)
sl1_image14 = sl1_cube(*,*,14)
sl1_image15 = sl1_cube(*,*,15)
sl1_image16 = sl1_cube(*,*,16)
sl1_image17 = sl1_cube(*,*,17)
sl1_image18 = sl1_cube(*,*,18)
sl1_image19 = sl1_cube(*,*,19)
sl1_image20 = sl1_cube(*,*,20)
sl1_image21 = sl1_cube(*,*,21)
sl1_image22 = sl1_cube(*,*,22)
sl1_image23 = sl1_cube(*,*,23)
sl1_image24 = sl1_cube(*,*,24)
sl1_image25 = sl1_cube(*,*,25)
sl1_image26 = sl1_cube(*,*,26)
sl1_image27 = sl1_cube(*,*,27)
sl1_image28 = sl1_cube(*,*,28)
sl1_image29 = sl1_cube(*,*,29)
sl1_image30 = sl1_cube(*,*,30)
sl1_image31 = sl1_cube(*,*,31)
sl1_image32 = sl1_cube(*,*,32)
sl1_image33 = sl1_cube(*,*,33)
sl1_image34 = sl1_cube(*,*,34)
sl1_image35 = sl1_cube(*,*,35)
sl1_image36 = sl1_cube(*,*,36)
sl1_image37 = sl1_cube(*,*,37)
sl1_image38 = sl1_cube(*,*,38)
sl1_image39 = sl1_cube(*,*,39)
sl1_image40 = sl1_cube(*,*,40)
sl1_image41 = sl1_cube(*,*,41)
sl1_image42 = sl1_cube(*,*,42)
sl1_image43 = sl1_cube(*,*,43)
sl1_image44 = sl1_cube(*,*,44)
sl1_image45 = sl1_cube(*,*,45)
sl1_image46 = sl1_cube(*,*,46)
sl1_image47 = sl1_cube(*,*,47)
sl1_image48 = sl1_cube(*,*,48)
sl1_image49 = sl1_cube(*,*,49)
sl1_image50 = sl1_cube(*,*,50)
sl1_image51 = sl1_cube(*,*,51)
sl1_image52 = sl1_cube(*,*,52)
sl1_image53 = sl1_cube(*,*,53)
sl1_image54 = sl1_cube(*,*,54)
sl1_image55 = sl1_cube(*,*,55)
sl1_image56 = sl1_cube(*,*,56)
sl1_image57 = sl1_cube(*,*,57)
sl1_image58 = sl1_cube(*,*,58)
sl1_image59 = sl1_cube(*,*,59)
sl1_image60 = sl1_cube(*,*,60)
sl1_image61 = sl1_cube(*,*,61)
sl1_image62 = sl1_cube(*,*,62)
sl1_image63 = sl1_cube(*,*,63)
sl1_image64 = sl1_cube(*,*,64)
sl1_image65 = sl1_cube(*,*,65)
sl1_image66 = sl1_cube(*,*,66)
sl1_image67 = sl1_cube(*,*,67)
sl1_image68 = sl1_cube(*,*,68)
sl1_image69 = sl1_cube(*,*,69)
sl1_image70 = sl1_cube(*,*,70)
sl1_image71 = sl1_cube(*,*,71)
sl1_image72 = sl1_cube(*,*,72)
sl1_image73 = sl1_cube(*,*,73)
sl1_image74 = sl1_cube(*,*,74)
sl1_image75 = sl1_cube(*,*,75)
sl1_image76 = sl1_cube(*,*,76)
sl1_image77 = sl1_cube(*,*,77)
sl1_image78 = sl1_cube(*,*,78)
sl1_image79 = sl1_cube(*,*,79)
sl1_image80 = sl1_cube(*,*,80)
sl1_image81 = sl1_cube(*,*,81)
sl1_image82 = sl1_cube(*,*,82)
sl1_image83 = sl1_cube(*,*,83)
sl1_image84 = sl1_cube(*,*,84)
sl1_image85 = sl1_cube(*,*,85)
sl1_image86 = sl1_cube(*,*,86)
sl1_image87 = sl1_cube(*,*,87)
sl1_image88 = sl1_cube(*,*,88)
sl1_image89 = sl1_cube(*,*,89)
sl1_image90 = sl1_cube(*,*,90)
sl1_image91 = sl1_cube(*,*,91)
sl1_image92 = sl1_cube(*,*,92)
sl1_image93 = sl1_cube(*,*,93)
sl1_image94 = sl1_cube(*,*,94)
sl1_image95 = sl1_cube(*,*,95)
sl1_image96 = sl1_cube(*,*,96)
sl1_image97 = sl1_cube(*,*,97)
sl1_image98 = sl1_cube(*,*,98)
sl1_image99 = sl1_cube(*,*,99)
sl1_image100 = sl1_cube(*,*,100)
sl1_image101 = sl1_cube(*,*,101)
sl1_image102 = sl1_cube(*,*,102)
sl1_image103 = sl1_cube(*,*,103)
sl1_image104 = sl1_cube(*,*,104)
sl1_image105 = sl1_cube(*,*,105)
sl1_image106 = sl1_cube(*,*,106)
sl1_image107 = sl1_cube(*,*,107)
sl1_image108 = sl1_cube(*,*,108)
sl1_image109 = sl1_cube(*,*,109)
sl1_image110 = sl1_cube(*,*,110)
sl1_image111 = sl1_cube(*,*,111)
sl1_image112 = sl1_cube(*,*,112)
sl1_image113 = sl1_cube(*,*,113)
sl1_image114 = sl1_cube(*,*,114)
sl1_image115 = sl1_cube(*,*,115)
sl1_image116 = sl1_cube(*,*,116)

hastrom, sl2_image0, sl2_cube_header0, sl1_cube_header, MISSING = 0
hastrom, sl2_image1, sl2_cube_header1, sl1_cube_header, MISSING = 0
hastrom, sl2_image2, sl2_cube_header2, sl1_cube_header, MISSING = 0
hastrom, sl2_image3, sl2_cube_header3, sl1_cube_header, MISSING = 0
hastrom, sl2_image4, sl2_cube_header4, sl1_cube_header, MISSING = 0
hastrom, sl2_image5, sl2_cube_header5, sl1_cube_header, MISSING = 0
hastrom, sl2_image6, sl2_cube_header6, sl1_cube_header, MISSING = 0
hastrom, sl2_image7, sl2_cube_header7, sl1_cube_header, MISSING = 0
hastrom, sl2_image8, sl2_cube_header8, sl1_cube_header, MISSING = 0
hastrom, sl2_image9, sl2_cube_header9, sl1_cube_header, MISSING = 0 
hastrom, sl2_image10, sl2_cube_header10, sl1_cube_header, MISSING = 0
hastrom, sl2_image11, sl2_cube_header11, sl1_cube_header, MISSING = 0
hastrom, sl2_image12, sl2_cube_header12, sl1_cube_header, MISSING = 0
hastrom, sl2_image13, sl2_cube_header13, sl1_cube_header, MISSING = 0
hastrom, sl2_image14, sl2_cube_header14, sl1_cube_header, MISSING = 0
hastrom, sl2_image15, sl2_cube_header15, sl1_cube_header, MISSING = 0
hastrom, sl2_image16, sl2_cube_header16, sl1_cube_header, MISSING = 0
hastrom, sl2_image17, sl2_cube_header17, sl1_cube_header, MISSING = 0
hastrom, sl2_image18, sl2_cube_header18, sl1_cube_header, MISSING = 0
hastrom, sl2_image19, sl2_cube_header19, sl1_cube_header, MISSING = 0 
hastrom, sl2_image20, sl2_cube_header20, sl1_cube_header, MISSING = 0
hastrom, sl2_image21, sl2_cube_header21, sl1_cube_header, MISSING = 0
hastrom, sl2_image22, sl2_cube_header22, sl1_cube_header, MISSING = 0
hastrom, sl2_image23, sl2_cube_header23, sl1_cube_header, MISSING = 0
hastrom, sl2_image24, sl2_cube_header24, sl1_cube_header, MISSING = 0
hastrom, sl2_image25, sl2_cube_header25, sl1_cube_header, MISSING = 0
hastrom, sl2_image26, sl2_cube_header26, sl1_cube_header, MISSING = 0
hastrom, sl2_image27, sl2_cube_header27, sl1_cube_header, MISSING = 0
hastrom, sl2_image28, sl2_cube_header28, sl1_cube_header, MISSING = 0
hastrom, sl2_image29, sl2_cube_header29, sl1_cube_header, MISSING = 0
hastrom, sl2_image30, sl2_cube_header30, sl1_cube_header, MISSING = 0
hastrom, sl2_image31, sl2_cube_header31, sl1_cube_header, MISSING = 0
hastrom, sl2_image32, sl2_cube_header32, sl1_cube_header, MISSING = 0
hastrom, sl2_image33, sl2_cube_header33, sl1_cube_header, MISSING = 0
hastrom, sl2_image34, sl2_cube_header34, sl1_cube_header, MISSING = 0
hastrom, sl2_image35, sl2_cube_header35, sl1_cube_header, MISSING = 0
hastrom, sl2_image36, sl2_cube_header36, sl1_cube_header, MISSING = 0
hastrom, sl2_image37, sl2_cube_header37, sl1_cube_header, MISSING = 0
hastrom, sl2_image38, sl2_cube_header38, sl1_cube_header, MISSING = 0
hastrom, sl2_image39, sl2_cube_header39, sl1_cube_header, MISSING = 0 
hastrom, sl2_image40, sl2_cube_header40, sl1_cube_header, MISSING = 0
hastrom, sl2_image41, sl2_cube_header41, sl1_cube_header, MISSING = 0
hastrom, sl2_image42, sl2_cube_header42, sl1_cube_header, MISSING = 0
hastrom, sl2_image43, sl2_cube_header43, sl1_cube_header, MISSING = 0
hastrom, sl2_image44, sl2_cube_header44, sl1_cube_header, MISSING = 0
hastrom, sl2_image45, sl2_cube_header45, sl1_cube_header, MISSING = 0
hastrom, sl2_image46, sl2_cube_header46, sl1_cube_header, MISSING = 0
hastrom, sl2_image47, sl2_cube_header47, sl1_cube_header, MISSING = 0
hastrom, sl2_image48, sl2_cube_header48, sl1_cube_header, MISSING = 0
hastrom, sl2_image49, sl2_cube_header49, sl1_cube_header, MISSING = 0 
hastrom, sl2_image50, sl2_cube_header50, sl1_cube_header, MISSING = 0
hastrom, sl2_image51, sl2_cube_header51, sl1_cube_header, MISSING = 0
hastrom, sl2_image52, sl2_cube_header52, sl1_cube_header, MISSING = 0
hastrom, sl2_image53, sl2_cube_header53, sl1_cube_header, MISSING = 0
hastrom, sl2_image54, sl2_cube_header54, sl1_cube_header, MISSING = 0
hastrom, sl2_image55, sl2_cube_header55, sl1_cube_header, MISSING = 0
hastrom, sl2_image56, sl2_cube_header56, sl1_cube_header, MISSING = 0
hastrom, sl2_image57, sl2_cube_header57, sl1_cube_header, MISSING = 0
hastrom, sl2_image58, sl2_cube_header58, sl1_cube_header, MISSING = 0
hastrom, sl2_image59, sl2_cube_header59, sl1_cube_header, MISSING = 0 
hastrom, sl2_image60, sl2_cube_header60, sl1_cube_header, MISSING = 0
hastrom, sl2_image61, sl2_cube_header61, sl1_cube_header, MISSING = 0
hastrom, sl2_image62, sl2_cube_header62, sl1_cube_header, MISSING = 0
hastrom, sl2_image63, sl2_cube_header63, sl1_cube_header, MISSING = 0
hastrom, sl2_image64, sl2_cube_header64, sl1_cube_header, MISSING = 0
hastrom, sl2_image65, sl2_cube_header65, sl1_cube_header, MISSING = 0
hastrom, sl2_image66, sl2_cube_header66, sl1_cube_header, MISSING = 0
hastrom, sl2_image67, sl2_cube_header67, sl1_cube_header, MISSING = 0
hastrom, sl2_image68, sl2_cube_header68, sl1_cube_header, MISSING = 0
hastrom, sl2_image69, sl2_cube_header69, sl1_cube_header, MISSING = 0 
hastrom, sl2_image70, sl2_cube_header70, sl1_cube_header, MISSING = 0
hastrom, sl2_image71, sl2_cube_header71, sl1_cube_header, MISSING = 0
hastrom, sl2_image72, sl2_cube_header72, sl1_cube_header, MISSING = 0
hastrom, sl2_image73, sl2_cube_header73, sl1_cube_header, MISSING = 0
hastrom, sl2_image74, sl2_cube_header74, sl1_cube_header, MISSING = 0
hastrom, sl2_image75, sl2_cube_header75, sl1_cube_header, MISSING = 0
hastrom, sl2_image76, sl2_cube_header76, sl1_cube_header, MISSING = 0


sl2 = [[[sl2_image0]],[[sl2_image1]],[[sl2_image2]],[[sl2_image3]],[[sl2_image4]],[[sl2_image5]],[[sl2_image6]],[[sl2_image7]],[[sl2_image8]],[[sl2_image9]],[[sl2_image10]],[[sl2_image11]],[[sl2_image12]],[[sl2_image13]],[[sl2_image14]],[[sl2_image15]],[[sl2_image16]],[[sl2_image17]],[[sl2_image18]],[[sl2_image19]],[[sl2_image20]],[[sl2_image21]],[[sl2_image22]],[[sl2_image23]],[[sl2_image24]],[[sl2_image25]],[[sl2_image26]],[[sl2_image27]],[[sl2_image28]],[[sl2_image29]],[[sl2_image30]],[[sl2_image31]],[[sl2_image32]],[[sl2_image33]],[[sl2_image34]],[[sl2_image35]],[[sl2_image36]],[[sl2_image37]],[[sl2_image38]],[[sl2_image39]],[[sl2_image40]],[[sl2_image41]],[[sl2_image42]],[[sl2_image43]],[[sl2_image44]],[[sl2_image45]],[[sl2_image46]],[[sl2_image47]],[[sl2_image48]],[[sl2_image49]],[[sl2_image50]],[[sl2_image51]],[[sl2_image52]],[[sl2_image53]],[[sl2_image54]],[[sl2_image55]],[[sl2_image56]],[[sl2_image57]],[[sl2_image58]],[[sl2_image59]],[[sl2_image60]],[[sl2_image61]],[[sl2_image62]],[[sl2_image63]],[[sl2_image64]],[[sl2_image65]],[[sl2_image66]],[[sl2_image67]],[[sl2_image68]],[[sl2_image69]],[[sl2_image70]],[[sl2_image71]],[[sl2_image72]],[[sl2_image73]],[[sl2_image74]],[[sl2_image75]],[[sl2_image76]]]

sl1 = sl1_cube

complete_cube = [[[sl2]],[[sl1]]]
concat_cube_header = sl2_cube_header
naxis3 = n_elements(complete_cube(0,0,*))
sxaddpar, concat_cube_header, 'NAXIS', 3
sxaddpar, concat_cube_header, 'NAXIS3', naxis3


writefits, sl_output, complete_cube, concat_cube_header

;writefits, 'll1_image0.fits', ll1_image0, ll1_cube_header
;writefits, 'll1_image1.fits', ll1_image1, ll1_cube_header
;writefits, 'll2_image0.fits', ll2_image0, ll2_cube_header
;writefits, 'sl1_image0.fits', sl1_image0, sl1_cube_header
;writefits, 'sl2_image0.fits', sl2_image0, sl2_cube_header

end
