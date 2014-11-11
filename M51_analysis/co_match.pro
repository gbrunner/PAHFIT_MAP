oiv = mrdfits('warm_hydrogen_temperature_again.fits', 0, oiv_header)
co = mrdfits('NGC5194mom0h.fits',0, co_header)
for i=0,n_elements(oiv(*,0))-1,1 do begin
for j=0,n_elements(oiv(0,*))-1,1 do begin

;if oiv(i,j) ne oiv(i,j) then oiv(i,j) = 0
if oiv(i,j) eq 0 then oiv(i,j) = 10

endfor
endfor

hastrom, oiv, oiv_header, co_header, MISSING=0
for i=0,n_elements(oiv(*,0))-1,1 do begin
for j=0,n_elements(oiv(0,*))-1,1 do begin

if oiv(i,j) ne oiv(i,j) then oiv(i,j) = 0
;if oiv(i,j) eq 0 then oiv(i,j) = 10

endfor
endfor

mwrfits, oiv, 'warm_h2_temp_map.fits', co_header
end
