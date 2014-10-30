s2_flux = mrdfits('H12_map.fits', 0, s2_header)
s3_flux = mrdfits('H9_map.fits', 0, s3_header)
s5_flux = mrdfits('H7_map.fits', 0, s5_header)

s2_unc = mrdfits('H12_map_unc.fits', 0)
s3_unc = mrdfits('H9_map_unc.fits', 0)
s5_unc = mrdfits('H7_map_unc.fits', 0)

for i=0,n_elements(s2_flux(*,0))-1,1 do begin
for j=0,n_elements(s2_flux(0,*))-1,1 do begin

if s2_flux(i,j) LT 1.45642E-12 then s2_flux(i,j)=1.45642E-12

endfor
endfor

mwrfits, s2_flux, 's2_rezero.fits', s2_header

for i=0,n_elements(s3_flux(*,0))-1,1 do begin
for j=0,n_elements(s3_flux(0,*))-1,1 do begin

if s3_flux(i,j) LT 3.03597E-12 then s3_flux(i,j)=3.03597E-12

endfor
endfor

mwrfits, s3_flux, 's3_rezero.fits', s3_header

for i=0,n_elements(s5_flux(*,0))-1,1 do begin
for j=0,n_elements(s5_flux(0,*))-1,1 do begin

if s5_flux(i,j) LT 7.30594E-12 then s5_flux(i,j)=7.30594E-12

endfor
endfor

mwrfits, s5_flux, 's5_rezero.fits', s5_header


s_flux = [[[s2_flux]], [[s3_flux]], [[s5_flux]]]
s_unc  = [[[s2_unc]], [[s3_unc]], [[s5_unc]]]

x = n_elements(s_flux[*,0,0]) 
y = n_elements(s_flux[0,*,0])
z = n_elements(s_flux[0,0,*])

energy = [1682, 2504, 4586]
g = [9,33,45]
a = [2.76e-9, 9.84e-9, 5.88e-8]
lambda = [12.28e-6, 9.66e-6, 6.91e-6]
c = 3.00e8
frequency = c/lambda 
ni_gi = fltarr(3)
h = 6.626e-34
beam = 17170.6825

ni_gi = fltarr(x,y,z)
temp_excite_plot = fltarr(x,y,z)
t_warm_excite = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

ni_gi(i,j,*) = 4*!pi*s_flux(i,j,*)/(h*A*frequency*g*beam)
temp_excite_plot = alog(ni_gi)
;warm_linear_fit = linfit(energy, temp_excite_plot(i,j,*))
;t_warm_excite(i,j) = -1/warm_linear_fit[1]

;plot, energy, temp_excite_plot(i,j,*), psym=4, $
;xtitle='Upper Level Energy (K)', ytitle='N(i)/g(i)', $
;title='Temperature Excitation Diagram of Whole Strip'


endfor
endfor

recip = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

linear_fit = linfit(energy, temp_excite_plot(i,j,*))
recip(i,j) = linear_fit[1] 
t_warm = -1/recip

endfor
endfor

;ni_gi_unc = 4*!pi*(s_flux - s_unc)/(h*A*frequency*g*beam)
;temp_excite_plot_unc = temp_excite_plot - alog(ni_gi_unc)
;temp_unc = alog(ni_gi_unc)
;warm_linear_fit_unc = linfit(energy[2:5], temp_unc[2:5])
;t_warm_excite_unc = -1/warm_linear_fit_unc[1] 

;oploterror, energy, temp_excite_plot, temp_excite_plot_unc, psym=3

;print, 't_unc(cold) =', t_cold_excite_unc
;print, 't_unc(warm) =', t_warm_excite_unc

;pf_warm = 0.0247*t_warm_excite/(1-exp(-6000/t_warm_excite))
;n_warm = ni_gi[2]*pf_warm/(exp(-energy[2]/t_warm_excite))
;print, 'n(warm) =', n_warm

end
