h28_map = mrdfits('H28_map.fits', 0, h28_header)
h17_map = mrdfits('H17_map.fits', 0, h17_header)
h12_map = mrdfits('H12_map.fits', 0, h12_header)
h9_map = mrdfits('H9_map.fits', 0, h9_header)
h8_map = mrdfits('H8_map.fits', 0, h8_header)
h7_map = mrdfits('H7_map.fits', 0, h7_header)

h28_unc = mrdfits('H28_map_unc.fits', 0, h28_unc_header)
h17_unc = mrdfits('H17_map_unc.fits', 0, h17_unc_header)
H12_unc = mrdfits('H12_map_unc.fits', 0, h12_unc_header)
h9_unc = mrdfits('H9_map_unc.fits', 0, h9_unc_header)
h8_unc = mrdfits('H8_map_unc.fits', 0, h8_unc_header)
h7_unc = mrdfits('H7_map_unc.fits', 0, h7_unc_header)

for i=0,n_elements(h12_unc(*,0))-1,1 do begin
for j=0,n_elements(h12_unc(0,*))-1,1 do begin

if h12_unc(i,j) ne h12_unc(i,j) then h12_unc(i,j) = 2.22e-8

endfor
endfor

for i=0,n_elements(h12_unc(*,0))-1,1 do begin
for j=0,n_elements(h12_unc(0,*))-1,1 do begin

if h9_unc(i,j) ne h9_unc(i,j) then h9_unc(i,j) = 1.121e-8

endfor
endfor

for i=0,n_elements(h12_unc(*,0))-1,1 do begin
for j=0,n_elements(h12_unc(0,*))-1,1 do begin

if h8_unc(i,j) ne h8_unc(i,j) then h8_unc(i,j) = 7.642e-9

endfor
endfor

for i=0,n_elements(h12_unc(*,0))-1,1 do begin
for j=0,n_elements(h12_unc(0,*))-1,1 do begin

if h7_unc(i,j) ne h7_unc(i,j) then h7_unc(i,j) = 1.0e-8

endfor
endfor


H28_smooth = h28_map
h17_smooth = h17_map
;h28_smooth = filter_image(h28_map, FWHM = 1, /ALL)
;h17_smooth = filter_image(h17_map, FWHM = 1, /ALL)
h12_smooth = filter_image(h12_map, FWHM = 7.5, /ALL)
h9_smooth = filter_image(h9_map, FWHM = 7.5, /ALL)
h8_smooth = filter_image(h8_map, FWHM = 7.5, /ALL)
h7_smooth = filter_image(h7_map, FWHM = 7.5, /ALL)

h28_unc_smooth = h28_unc
h17_unc_smooth = h17_unc
;h28_smooth = filter_image(h28_map, FWHM = 1, /ALL)
;h17_smooth = filter_image(h17_map, FWHM = 1, /ALL)
h12_unc_smooth = filter_image(h12_unc, FWHM = 7.5, /ALL)
h9_unc_smooth = filter_image(h9_unc, FWHM = 7.5, /ALL)
h8_unc_smooth = filter_image(h8_unc, FWHM = 7.5, /ALL)
h7_unc_smooth = filter_image(h7_unc, FWHM = 7.5, /ALL)

mwrfits, h28_smooth, 'H28_smooth.fits', h28_header
mwrfits, h17_smooth, 'H17_smooth.fits', h17_header
mwrfits, h12_smooth, 'H12_smooth.fits', h12_header
mwrfits, h8_smooth, 'H8_smooth.fits', h8_header
mwrfits, h9_smooth, 'H9_smooth.fits', h9_header
mwrfits, h7_smooth, 'H7_smooth.fits', h7_header

hastrom, h12_smooth, h12_header, h28_header, MISSING=0
hastrom, h9_smooth, h9_header, h28_header, MISSING=0
hastrom, h8_smooth, h8_header, h28_header, MISSING=0
hastrom, h7_smooth, h7_header, h28_header, MISSING=0

hastrom, h12_unc, h12_unc_header, h28_header, MISSING=0
hastrom, h9_unc, h9_unc_header, h28_header, MISSING=0
hastrom, h8_unc, h8_unc_header, h28_header, MISSING=0
hastrom, h7_unc, h7_unc_header, h28_header, MISSING=0

mwrfits, h12_smooth, 'H12_interpol.fits', h28_header
mwrfits, h9_smooth, 'H9_interpol.fits', h28_header
mwrfits, h8_smooth, 'H8_interpol.fits', h28_header
mwrfits, h7_smooth, 'H7_interpol.fits', h28_header

s_flux = [[[h28_smooth]],[[h17_smooth]],[[h12_smooth]], [[h9_smooth]], [[h8_smooth]], [[h7_smooth]]]

s_unc = [[[h28_unc]],[[h17_unc]],[[h12_unc]], [[h9_unc]], [[h8_unc]], [[h7_unc]]]

;s_unc = [[[h28_unc_smooth]],[[h17_unc_smooth]],[[h12_unc_smooth]], [[h9_unc_smooth]], [[h8_unc_smooth]], [[h7_unc_smooth]]]
;s_flux = [[[h12_smooth]], [[h9_smooth]], [[h8_smooth]], [[h7_smooth]]]
;s_unc  = [[[s2_unc]], [[s3_unc]], [[s5_unc]]]

x = n_elements(s_flux[*,0,0]) 
y = n_elements(s_flux[0,*,0])
z = n_elements(s_flux[0,0,*])

;cold
energy = [510, 1015, 1682, 2504, 3474, 4586]
g = [5,21/3,9,33/3,13, 45/3]
a = [2.96e-11, 4.76e-10, 2.76e-9, 9.84e-9, 2.64e-8, 5.88e-8]
lambda = [28.22e-6, 17.04e-6, 12.28e-6, 9.66e-6, 8.026e-6, 6.91e-6]


;warm
;energy = [1682, 2504, 3474, 4586]
;g = [9,33,13,45]
;a = [2.76e-9, 9.84e-9, 2.64e-8, 5.88e-8]
;lambda = [12.28e-6, 9.66e-6, 8.026e-6, 6.91e-6]


c = 3.00e8
frequency = c/lambda 
ni_gi = fltarr(6)
h = 6.626e-34
;beam = 1

ni_gi = fltarr(x,y,z)
temp_excite_plot = fltarr(x,y,z)
t_cold_excite = fltarr(x,y)
t_warm_excite = fltarr(x,y)

delta_ni_gi = fltarr(x,y,z)
delta_temp_excite_plot = fltarr(x,y,z)
delta_t_warm_excite = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

;ni_gi(i,j,*) = 4*!pi*s_flux(i,j,*)/(h*A*frequency*g*beam)
ni_gi(i,j,*) = s_flux(i,j,*)/(h*A*frequency*g)
temp_excite_plot = alog(ni_gi)

endfor
endfor

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

;ni_gi(i,j,*) = 4*!pi*s_flux(i,j,*)/(h*A*frequency*g*beam)
delta_ni_gi(i,j,*) = s_unc(i,j,*)/(h*A*frequency*g)
delta_temp_excite_plot = alog(delta_ni_gi)

endfor
endfor

error = temp_excite_plot - delta_temp_excite_plot

warm_recip = fltarr(x,y)
cold_recip = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

cold_linear_fit = linfit(energy[0:2], temp_excite_plot(i,j,0:2))
cold_recip(i,j) = cold_linear_fit[1] 
t_cold = -1/cold_recip

endfor
endfor


for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

warm_linear_fit = linfit(energy[2:5], temp_excite_plot(i,j,2:5))
warm_recip(i,j) = warm_linear_fit[1] 
t_warm = -1/warm_recip

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
size_pixel_pc = 236.43
size_pixel = size_pixel_pc/3.24e-17   ;in meters
area_pixel = size_pixel^2
mol_mass = 2*(1.674e-27)
;m_hydrogen = n*area_pixel*mol_mass/solar_mass
m_hydrogen = n*2.94117e-16

n0_para = ni_gi[*,*,0]*pf/(exp(-energy[0]/t_cold[*,*]))
n1_ortho = ni_gi[*,*,1]*pf/(exp(-energy[1]/t_cold[*,*]))
n2_para = ni_gi[*,*,2]*pf/(exp(-energy[2]/t_warm[*,*]))
n3_ortho = ni_gi[*,*,3]*pf/(exp(-energy[3]/t_warm[*,*]))
n4_para = ni_gi[*,*,4]*pf/(exp(-energy[4]/t_warm[*,*]))
n5_ortho = ni_gi[*,*,5]*pf/(exp(-energy[5]/t_warm[*,*]))


alog_ni_gi_ortho = [[[temp_excite_plot[*,*,2]]], [[temp_excite_plot[*,*,4]]]]
alog_ni_gi_para  = [[[temp_excite_plot[*,*,2]]], [[temp_excite_plot[*,*,4]]]]
energy_ortho = [energy[2],energy[4]]
energy_para  = [energy[3],energy[5]]

;opr1 = fltarr(x,y)
;log_opr1 = fltarr(x,y)

;for i=0,x-1,1 do begin
;for j=0,y-1,1 do begin

;a = 2504
;int = interpol(alog_ni_gi_ortho[i,j,*], energy_ortho, a)
;log_opr1[i,j] = alog_ni_gi_para[i,j,0] - int
;opr1[i,j] = exp(log_opr1[i,j])

;endfor
;endfor


;opr2 = fltarr(x,y)
;log_opr2 = fltarr(x,y)

;for i=0,x-1,1 do begin
;for j=0,y-1,1 do begin

;a = 4586
;int = interpol(alog_ni_gi_ortho[i,j,*], energy_ortho, a)
;log_opr2[i,j] = alog_ni_gi_para[i,j,1] - int
;opr2[i,j] = exp(log_opr2[i,j])

;endfor
;endfor

opr = fltarr(x,y)
log_opr = fltarr(x,y)

for i=0,x-1,1 do begin
for j=0,y-1,1 do begin

a = 1682
int = interpol(alog_ni_gi_para[i,j,*], energy_para, a)
log_opr[i,j] = int - alog_ni_gi_ortho[i,j,0]
opr[i,j]= exp(log_opr[i,j])

endfor
endfor

mwrfits, opr, 'opr.fits', h28_header

end


