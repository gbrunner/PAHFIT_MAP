data = mrdfits('H12_map.fits',0, header)
x_max = 65 ;n_elements(data(*,0))-1
x_min = 48
y_max = 14 ;n_elements(data(0,*))-1
y_min = 2
;trim_data = data[x_min:x_max, y_min:y_max]
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


mwrfits, trim_data, 'H12_map_trim.fits', header

end
