
cold_mass = mrdfits('cold_mass_dist.fits', 0, cold_mass_header)
warm_mass = mrdfits('warm_mass_dist.fits', 0, warm_mass_header)
cold_temp = mrdfits('cold_hydrogen_temperature.fits', 0, cold_temp_header)
warm_temp = mrdfits('warm_hydrogen_temperature.fits', 0, warm_temp_header)
co = mrdfits('NGC5194mom0h.fits', 0, co_header)

hastrom, warm_mass, warm_mass_header, co_header, MISSING=0
hastrom, cold_temp, cold_temp_header, co_header, MISSING=0
hastrom, warm_temp, warm_temp_header, co_header, MISSING=0

for i=0,n_elements(cold_mass(*,0))-1,1 do begin
for j=0,n_elements(cold_mass(0,*))-1,1 do begin

;print, i,j
if cold_mass(i,j) LT 10 then cold_mass(i,j)=10

endfor 
endfor

hastrom, cold_mass, cold_mass_header, co_header, MISSING=0

for i=0,n_elements(cold_mass(*,0))-1,1 do begin
for j=0,n_elements(cold_mass(0,*))-1,1 do begin

;print, i,j
if cold_mass(i,j) ne cold_mass(i,j) then cold_mass(i,j)=0

endfor 
endfor

for i=0,n_elements(warm_mass(*,0))-1,1 do begin
for j=0,n_elements(warm_mass(0,*))-1,1 do begin

;print, i,j
if warm_mass(i,j) LT .01 then warm_mass(i,j)=0

endfor 
endfor

for i=0,n_elements(warm_mass(*,0))-1,1 do begin
for j=0,n_elements(warm_mass(0,*))-1,1 do begin

;print, i,j
if warm_mass(i,j) ne warm_mass(i,j) then warm_mass(i,j)=0

endfor 
endfor

;mwrfits, cold_mass, 'cold_mass_contour_plot.fits', co_header

;for i=0,n_elements(cold_temp(*,0))-1,1 do begin
;for j=0,n_elements(cold_temp(0,*))-1,1 do begin;

;print, i,j
;if mass(i,j) LT 10 then mass(i,j)=10

;endfor 
;endfor

;mwrfits, mass, 'mass_contour_plot.fits', mass_header
;mwrfits, warm_mass, 'warm_mass_contour_plot.fits', co_header
;mwrfits, cold_temp, 'cold_temp_contour_plot.fits', co_header
mwrfits, warm_temp, 'warm_temp_contour_plot.fits', co_header

end
