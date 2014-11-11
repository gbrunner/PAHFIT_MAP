warm = mrdfits('warm_hydrogen_temperature.fits', 0, warm_header)
opr = mrdfits('opr.fits', 0, opr_header)
co = mrdfits('NGC5194mom0h.fits',0, co_header)

for i=0,n_elements(opr(*,0))-1,1 do begin
for j=0,n_elements(opr(0,*))-1,1 do begin

;print, i,j
if opr(i,j) NE opr(i,j) then opr(i,j)=0

endfor 
endfor

hastrom, opr, opr_header, co_header, MISSING=0
mwrfits, opr, 'opr_contour_plot.fits', opr_header

for i=0,n_elements(warm(*,0))-1,1 do begin
for j=0,n_elements(warm(0,*))-1,1 do begin

if warm(i,j) NE warm(i,j) then warm(i,j)=0

endfor
endfor

hastrom, warm, warm_header, co_header, MISSING=0
mwrfits, warm, 'warm_temp_contour_plot.fits', warm_header

end
