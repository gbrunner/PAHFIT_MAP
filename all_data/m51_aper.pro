
h28_map = mrdfits('H28_map.fits', 0, h28_header)
h17_map = mrdfits('H17_map.fits', 0, h17_header)
h12_map = mrdfits('H12_map.fits', 0, h12_header)
h9_map = mrdfits('H9_map.fits', 0, h9_header)
h7_map = mrdfits('H7_map.fits', 0, h7_header)

h28_smooth = h28_map
h17_smooth = h17_map
;h28_smooth = filter_image(h28_map, FWHM = 1, /ALL)
;h17_smooth = filter_image(h17_map, FWHM = 1, /ALL)
h12_smooth = filter_image(h12_map, FWHM = 7.5, /ALL)
h9_smooth = filter_image(h9_map, FWHM = 7.5, /ALL)
h7_smooth = filter_image(h7_map, FWHM =7.5, /ALL)

;mwrfits, h28_smooth, 'H28_smooth.fits', h28_header
;mwrfits, h17_smooth, 'H17_smooth.fits', h17_header
;mwrfits, h12_smooth, 'H12_smooth.fits', h12_header
;mwrfits, h9_smooth, 'H9_smooth.fits', h9_header
;mwrfits, h7_smooth, 'H7_smooth.fits', h7_header

hastrom, h12_smooth, h12_header, h28_header, MISSING=0
hastrom, h9_smooth, h9_header, h28_header, MISSING=0
hastrom, h7_smooth, h7_header, h28_header, MISSING=0

;mwrfits, h12_smooth, 'H12_interpol.fits', h28_header
;mwrfits, h9_smooth, 'H9_interpol.fits', h28_header
;mwrfits, h7_smooth, 'H7_interpol.fits', h28_header

s_flux = [[[h28_smooth]],[[h17_smooth]],[[h12_smooth]]];, [[h9_smooth]], [[h7_smooth]]]

;s_flux = [[[h12_smooth]], [[h9_smooth]], [[h7_smooth]]]
;s_unc  = [[[s2_unc]], [[s3_unc]], [[s5_unc]]]

x = n_elements(s_flux[*,0,0]) 
y = n_elements(s_flux[0,*,0])
z = n_elements(s_flux[0,0,*])

;cold
energy = [510, 1015, 1682];, 2504, 4586]
g = [5,21,9];,33,45]
a = [2.96e-11, 4.76e-10, 2.76e-9];, 9.84e-9, 5.88e-8]
lambda = [28.22e-6, 17.04e-6, 12.28e-6];, 9.66e-6, 6.91e-6]


;warm
;energy = [1682, 2504, 4586]
;g = [9,33,45]
;a = [2.76e-9, 9.84e-9, 5.88e-8]
;lambda = [12.28e-6, 9.66e-6, 6.91e-6]


c = 3.00e8
frequency = c/lambda 
ni_gi = fltarr(3)
h = 6.626e-34
;beam = 1

ni_gi = fltarr(x,y,z)
temp_excite_plot = fltarr(x,y,z)
t_warm_excite = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

;ni_gi(i,j,*) = 4*!pi*s_flux(i,j,*)/(h*A*frequency*g*beam)
ni_gi(i,j,*) = s_flux(i,j,*)/(h*A*frequency*g)
temp_excite_plot = alog(ni_gi)

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

;mwrfits, t_warm, 'cold_hydrogen_temperature.fits', h28_header
;mwrfits, t_warm, 'warm_hydrogen_temperature.fits', h28_header

;calculate number density

pf = 0.0247*t_warm[*,*]/(1-exp(-6000/t_warm[*,*]))
;n = ni_gi[*,*,0]*pf/(exp(-energy[0]/t_warm))
n = ni_gi[*,*,0]*pf/(exp(-energy[0]/t_warm[*,*]))

solar_mass = 1.98892e30
distance = 9.6e6
size_pixel = 4.18e20
area_pixel = size_pixel^2
mol_mass = 2*(1.674e-27)
;m_hydrogen = n*area_pixel*mol_mass/solar_mass
m_hydrogen = n*2.94117e-16

;mwrfits, n, 'cold_hydrogen_number_density.fits', h28_header
;mwrfits, m_hydrogen, 'cold_hydrogen_mass.fits', h28_header
;mwrfits, n, 'warm_hydrogen_number_density.fits', h28_header
;mwrfits, m_hydrogen, 'warm_hydrogen_mass.fits', h28_header

end


