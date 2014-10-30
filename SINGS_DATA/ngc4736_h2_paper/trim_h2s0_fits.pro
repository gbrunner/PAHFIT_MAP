data = mrdfits('H28_map.fits',0, header)
x_max = 128 ;n_elements(data(*,0))-1
x_min = 57
y_max = n_elements(data(0,*))-1
y_min = 1
;trim_data = data[x_min:x_max, y_min:y_max]
data(90,7) = (data(91,7)+data(89,7)+data(90,8)+data(90,6))/4
data(90,3) = (data(91,3)+data(89,3)+data(90,4)+data(90,2))/4
data(91,1) = (data(92,1)+data(91,2)+data(90,1))/3
data(91,10) = (data(92,10)+data(91,9)+data(90,10))/3
data(89,8) = (data(89,9)+data(89,7)+data(88,8)+data(90,8))/4

trim_data = data[x_min:x_max,y_min:y_max]
;new_header = header
crpix1 = fxpar(header, 'CRPIX1')
print, crpix1
crpix2 = fxpar(header, 'CRPIX2')
print, crpix2
new_crpix1 = crpix1 - x_min
new_crpix2 = crpix2 - y_min
fxaddpar, header, 'CRPIX1', new_crpix1
fxaddpar, header, 'CRPIX2', new_crpix2

for i=0,n_elements(trim_data(*,0))-1,1 do begin
for j=0,n_elements(trim_data(0,*))-1,1 do begin

if trim_data(i,j) lt 1e-12 then trim_data(i,j) = 1e-12

endfor
endfor




mwrfits, trim_data, 'H28_map_trim.fits', header

end
