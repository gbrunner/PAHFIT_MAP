data = mrdfits('df_6_2_micron_dust_feature_mask.fits',0, header)
x_max = 66 ;n_elements(data(*,0))-1
x_min = 44
y_max = 15;n_elements(data(0,*))-1
y_min = 1
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


mwrfits, trim_data, 'df_6_2_map_crop_rezero.fits', header

end
