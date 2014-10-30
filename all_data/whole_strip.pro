readcol, 'SL2_whole_strip.tbl', sl2_wave, sl2_flux, sl2_unc
readcol, 'SL1_whole_strip.tbl', sl1_wave, sl1_flux, sl1_unc
readcol, 'LL2_whole_strip.tbl', ll2_wave, ll2_flux, ll2_unc
readcol, 'LL1_whole_strip.tbl', ll1_wave, ll1_flux, ll1_unc

sl2_num = n_elements(sl2_wave)
sl1_num = n_elements(sl1_wave)
ll2_num = n_elements(ll2_wave)
ll1_num = n_elements(ll1_wave)

wave = [sl2_wave[0:sl2_num-4], sl1_wave[1:sl1_num-3], $
        ll2_wave[3:ll2_num-2], ll1_wave[2:ll1_num-2]] 

flux = [sl2_flux[0:sl2_num-4], sl1_flux[1:sl1_num-3], $
        ll2_flux[3:ll2_num-2], ll1_flux[2:ll1_num-2]]

unc =  [sl2_unc[0:sl2_num-4], sl1_unc[1:sl1_num-3],$
        ll2_unc[3:ll2_num-2], ll1_unc[2:ll1_num-2]]

fit=pahfit(wave, flux, unc, REDSHIFT=0) ;, /PLOT_PROGRESS, XSIZE=1000, YSIZE=600, /SCREEN, /REPORT)

print, n_elements(fit.lines.name)

pahfit_flux = fit.lines.int_strength
pahfit_unc =  fit.lines.int_strength_unc


s0_flux = pahfit_flux[15]
s1_flux = pahfit_flux[11]
s2_flux = pahfit_flux[8]
s3_flux = pahfit_flux[6]
s4_flux = pahfit_flux[4]
s5_flux = pahfit_flux[2]

s0_unc = pahfit_unc[15]
s1_unc = pahfit_unc[11]
s2_unc = pahfit_unc[8]
s3_unc = pahfit_unc[6]
s4_unc = pahfit_unc[4]
s5_unc = pahfit_unc[2]

s_flux = [s0_flux, s1_flux, s2_flux, s3_flux, s4_flux, s5_flux]
s_unc  = [s0_unc, s1_unc, s2_unc, s3_unc, s4_unc, s5_unc]
energy = [510, 1015, 1682, 2504, 3474, 4586]
g = [5,21,9,33,13,45]
a = [2.94e-11, 4.76e-10, 2.76e-9, 9.84e-9, 2.64e-8, 5.88e-8]
lambda = [28.22e-6, 17.04e-6, 12.28e-6, 9.66e-6, 8.03e-6, 6.91e-6]
c = 3.00e8
frequency = c/lambda 
ni_gi = fltarr(6)
h = 6.626e-34
beam = 17170.6825

ni_gi = 4*!pi*s_flux/(h*A*frequency*g*beam)
temp_excite_plot = alog(ni_gi)
cold_linear_fit = linfit(energy[0:2], temp_excite_plot[0:2])
warm_linear_fit = linfit(energy[2:5], temp_excite_plot[2:5])
t_cold_excite = -1/cold_linear_fit[1]
t_warm_excite = -1/warm_linear_fit[1]

plot, energy, temp_excite_plot, psym=4, $
xtitle='Upper Level Energy (K)', ytitle='N(i)/g(i)', $
title='Temperature Excitation Diagram of Whole Strip'
print, 't(cold) =', t_cold_excite
print, 't(warm) =', t_warm_excite

ni_gi_unc = 4*!pi*(s_flux - s_unc)/(h*A*frequency*g*beam)
temp_excite_plot_unc = temp_excite_plot - alog(ni_gi_unc)
temp_unc = alog(ni_gi_unc)
cold_linear_fit_unc = linfit(energy[0:2], temp_unc[0:2])
warm_linear_fit_unc = linfit(energy[2:5], temp_unc[2:5])
t_cold_excite_unc = -1/cold_linear_fit_unc[1]
t_warm_excite_unc = -1/warm_linear_fit_unc[1] 

oploterror, energy, temp_excite_plot, temp_excite_plot_unc, psym=3

;plot, energy, temp_excite_plot_unc, psym=4, $
;xtitle='Upper Level Energy (K)', ytitle='N(i)/g(i)', $
;title='Temperature Excitation Diagram of Whole Strip'

print, 't_unc(cold) =', t_cold_excite_unc
print, 't_unc(warm) =', t_warm_excite_unc

pf_cold = 0.0247*t_cold_excite/(1-exp(-6000/t_cold_excite))
pf_warm = 0.0247*t_warm_excite/(1-exp(-6000/t_warm_excite))

; calculating the warm and cold number density from 
; the S(0) and S(1) lines


n_cold = ni_gi[0]*pf_cold/(exp(-energy[0]/t_cold_excite))
n_warm = ni_gi[2]*pf_warm/(exp(-energy[2]/t_warm_excite))

print, 'n(cold) =', n_cold
print, 'n(warm) =', n_warm

end
