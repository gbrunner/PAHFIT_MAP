

oiv = mrdfits('H9_map_trim.fits', 0, oiv_header)
co = mrdfits('NGC2403.bima.mmom0.fits',0, co_header)

;for i=0,n_elements(oiv(*,0))-1,1 do begin
;for j=0,n_elements(oiv(0,*))-1,1 do begin

;if oiv(i,j) ne oiv(i,j) then oiv(i,j) = 10

;endfor
;endfor


hastrom, oiv, oiv_header, co_header, MISSING=0
mwrfits, oiv, 'H9_match.fits', co_header
end
