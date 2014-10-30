

h28_map = mrdfits('H28_map.fits', 0, h28_header)
h17_map = mrdfits('H17_map.fits', 0, h17_header)
h12_map = mrdfits('H12_map.fits', 0, h12_header)
h9_map = mrdfits('H9_map.fits', 0, h9_header)
h7_map = mrdfits('H7_map.fits', 0, h7_header)

h28_smooth = filter_image(h28_map, FWHM = 1, /ALL)
h17_smooth = filter_image(h17_map, FWHM = 1, /ALL)
h12_smooth = filter_image(h12_map, FWHM = 7.5, /ALL)
h9_smooth = filter_image(h9_map, FWHM = 7.5, /ALL)
h7_smooth = filter_image(h7_map, FWHM =7.5, /ALL)

hastrom, h12_smooth, h12_header, h28_header, MISSING=0
hastrom, h9_smooth, h9_header, h28_header, MISSING=0
hastrom, h7_smooth, h7_header, h28_header, MISSING=0

;PARA maps
;Even transitions

s_flux = [[[h28_smooth]],[[h12_smooth]]]
;s_unc  = [[[s2_unc]], [[s3_unc]], [[s5_unc]]]

x = n_elements(s_flux[*,0,0]) 
y = n_elements(s_flux[0,*,0])
z = n_elements(s_flux[0,0,*])

energy = [510, 1682]
g = [5,9]
a = [2.96e-11, 2.76e-9]
lambda = [28.22e-6, 12.28e-6]
c = 3.00e8
frequency = c/lambda 
ni_gi = fltarr(5)
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
ortho_intercept = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

linear_fit = linfit(energy, temp_excite_plot(i,j,*))
recip(i,j) = linear_fit[1] 
ortho_intercept(i,j) = linear_fit[0]
t_warm = -1/recip

endfor
endfor

mwrfits, t_warm, 'ortho_temperature.fits', h28_header
mwrfits, ortho_intercept, 'ortho_intercept.fits', h28_header

end


