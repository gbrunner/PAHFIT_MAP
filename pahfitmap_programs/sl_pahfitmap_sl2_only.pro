



z=0
;z = 0.00154*299792.458
;cz in km/s



readcol, 'sl1_wave.tbl', fake_wave, fake_sl1_cube, fake_sl1_unc
sl2_cube = mrdfits('ngc5194_strip_SL2_cube.fits',0, sl1_header)
sl2_unc = mrdfits('ngc5194_strip_SL2_cube_unc.fits',0, sl1_unc_header)
sl2_cube = sl2_cube[43:72,1:175,*]
sl2_unc = sl2_unc[43:72,1:175,*]

sl1_x = n_elements(sl2_cube[*,0,0]) 
sl1_y = n_elements(sl2_cube[0,*,0])
sl1_z = n_elements(fake_wave)
sl1_cube = fltarr(sl1_x, sl1_y, 114)
sl1_unc = fltarr(sl1_x, sl1_y, 114)


;for i=0,10,1 do begin
;for j=0,10,1 do begin

;sl2_cube(i,j,*) = fake_sl2_cube
;sl2_unc(i,j,*) = fake_sl2_unc

;endfor
;endfor

;sl2_cube(0,0,*) = fake_sl2_cube
;sl2_unc(0,0,*) = fake_sl2_unc


;Read in Wavelength files
readcol, 'sl1_wave.tbl',  sl1_wave, sl1_junk1, sl1_junk2
readcol, 'sl2_wave.tbl',  sl2_wave, sl2_junk1, sl2_junk2

;Truncate wavelength just as we did the cubes
sl1_wave = sl1_wave[3:116]
;sl2_wave = sl2_wave[0:72]

;Stack cubes and wavelength

;sl_cube = [[[sl2_cube]], [[sl1_cube]]]
;sl_unc  = [[[sl2_unc]], [[sl1_unc]]]
sl_wave = [sl2_wave, sl1_wave]
wave    = sl_wave

;_______________________________________________________________________
;Cube Matching Algorithm (need to match cubes before putting in PAHFIT)

;sl_x = n_elements(sl1_cube(*,0,0))-1
;sl_y = n_elements(sl1_cube(0,*,0))-1

;for i=0,sl_x,1 do begin

;for j=0,sl_y,1 do begin

;med_sl1 = median(sl1_cube(i,j,0:4))
;med_sl2 = median(sl2_cube(i,j,72:76))

;sl_scale = med_sl1 - med_sl2

;sl2_cube[i,j,*] = sl2_cube[i,j,*] + sl_scale 

;endfor
;endfor


;________________________________________________________________________
;Cube smoothing algorithm
;smoothe cubes before PAHFIT instead of in PAHFIT

sl_cube = [[[sl2_cube]], [[sl1_cube]]]
sl_unc  = [[[sl2_unc]], [[sl1_unc]]]


old_cube = sl_cube
old_unc = sl_unc

new_cube = sl_cube
new_unc = sl_unc

x = n_elements(sl_cube(*,0,0))-1
y = n_elements(sl_cube(0,*,0))-1
z = n_elements(sl_cube(0,0,*))-1

x_crop = n_elements(sl_cube(*,0,0))-2
y_crop = n_elements(sl_cube(0,*,0))-2
z_crop = n_elements(sl_cube(0,0,*))-2

for i=1,x_crop,1 do begin
for j=1,y_crop,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i+1,j+1,*)+sl_cube(i-1,j-1,*)+sl_cube(i-1,j+1,*)+sl_cube(i+1,j-1,*)+sl_cube(i,j+1,*)+sl_cube(i,j-1,*)+sl_cube(i+1,j,*)+sl_cube(i-1,j,*))/9

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i+1,j+1,*)+sl_unc(i-1,j-1,*)+sl_unc(i-1,j+1,*)+sl_unc(i+1,j-1,*)+sl_unc(i,j+1,*)+sl_unc(i,j-1,*)+sl_unc(i+1,j,*)+sl_unc(i-1,j,*))/9

endfor
endfor

for i=0,0,1 do begin
for j=1,y_crop, 1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i+1,j+1,*)+sl_cube(i+1,j-1,*)+sl_cube(i,j+1,*)+sl_cube(i,j-1,*)+sl_cube(i+1,j,*))/6

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i+1,j+1,*)+sl_unc(i+1,j-1,*)+sl_unc(i,j+1,*)+sl_unc(i,j-1,*)+sl_unc(i+1,j,*))/6

endfor
endfor

for i=x,x,1 do begin
for j=1,y_crop,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i-1,j-1,*)+sl_cube(i-1,j+1,*)+sl_cube(i,j+1,*)+sl_cube(i,j-1,*)+sl_cube(i-1,j,*))/6

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i-1,j-1,*)+sl_unc(i-1,j+1,*)+sl_unc(i,j+1,*)+sl_unc(i,j-1,*)+sl_unc(i-1,j,*))/6

endfor
endfor

for j=0,0,1 do begin
for i=1,x_crop,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i+1,j+1,*)+sl_cube(i-1,j+1,*)+sl_cube(i,j+1,*)+sl_cube(i+1,j,*)+sl_cube(i-1,j,*))/6

new_unc(i,j,*) =  (sl_unc(i,j,*)+sl_unc(i+1,j+1,*)+sl_unc(i-1,j+1,*)+sl_unc(i,j+1,*)+sl_unc(i+1,j,*)+sl_unc(i-1,j,*))/6

endfor
endfor


for j=y,y,1 do begin
for i=1,x_crop,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i-1,j-1,*)+sl_cube(i+1,j-1,*)+sl_cube(i,j-1,*)+sl_cube(i+1,j,*)+sl_cube(i-1,j,*))/6

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i-1,j-1,*)+sl_unc(i+1,j-1,*)+sl_unc(i,j-1,*)+sl_unc(i+1,j,*)+sl_unc(i-1,j,*))/6

endfor
endfor

for j=0,0,1 do begin
for i=0,0,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i+1,j+1,*)+sl_cube(i,j+1,*)+sl_cube(i+1,j,*))/4

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i+1,j+1,*)+sl_unc(i,j+1,*)+sl_unc(i+1,j,*))/4

endfor
endfor

for j=0,0,1 do begin
for i=x,x,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i-1,j+1,*)+sl_cube(i,j+1,*)+sl_cube(i-1,j,*))/4

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i-1,j+1,*)+sl_unc(i,j+1,*)+sl_unc(i-1,j,*))/4

endfor
endfor

for j=y,y,1 do begin
for i=0,0,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i+1,j-1,*)+sl_cube(i,j-1,*)+sl_cube(i+1,j,*))/4

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i+1,j-1,*)+sl_unc(i,j-1,*)+sl_unc(i+1,j,*))/4

endfor
endfor

for j=y,y,1 do begin
for i=x,x,1 do begin

new_cube(i,j,*) = (sl_cube(i,j,*)+sl_cube(i-1,j-1,*)+sl_cube(i,j-1,*)+sl_cube(i-1,j,*))/4

new_unc(i,j,*) = (sl_unc(i,j,*)+sl_unc(i-1,j-1,*)+sl_unc(i,j-1,*)+sl_unc(i-1,j,*))/4

endfor
endfor

;mwrfits, new_cube, 'sl_cube_test.fits'
;mwrfits, new_unc, 'sl_unc_test.fits'

sl_cube = new_cube
sl_unc = new_unc


;_______________________________________________________

;Initialize PAHFIT_CUBE
fit_cube  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)), n_elements(wave))
cont_fit  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)), n_elements(wave))

;Initialize ionization maps
H2_s7     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s6     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s5     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArII      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s4     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArIII     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s3     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
SIV       = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s2     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
NeII      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize line FWHMs
H2_s7_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s6_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s5_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArII_fwhm     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s4_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArIII_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s3_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
SIV_fwhm      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s2_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
NeII_fwhm     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize equivalent width maps
ew_H2_s7     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_H2_s6     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_H2_s5     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_ArII      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_H2_s4     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_ArIII     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_H2_s3     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_SIV       = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_H2_s2     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ew_NeII      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Integrated strength uncertainty
H2_s7_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s6_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s5_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArII_unc      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s4_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
ArIII_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s3_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
SIV_unc       = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
H2_s2_unc     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
NeII_unc      = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize Dust Feature Arrays
df_14_1_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_14_0_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_13_5_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_7_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_6_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_micron    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_3_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_2_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_10_7_micron  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_6_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_3_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_8_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_6_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_4_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_7_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_2_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_7_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_2_micron   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize Dust FWHM arrays
df_14_1_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_14_0_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_13_5_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_7_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_6_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_micron_fwhm    = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_3_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_2_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_10_7_micron_fwhm  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_6_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_3_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_8_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_6_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_4_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_7_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_2_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_7_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_2_micron_fwhm   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize Dust Feature Uncertainty Arrays
df_14_1_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_14_0_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_13_5_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_7_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_6_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_12_micron_unc   = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_3_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_11_2_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_10_7_micron_unc = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_6_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_8_3_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_8_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_6_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_7_4_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_7_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_6_2_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_7_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
df_5_2_micron_unc  = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Chi Squared Array
chi_sq = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize beta
beta_pahfit     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
beta_unc_pahfit = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

;Initialize tau 9.7 
tau_9_7_pahfit     = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))
tau_9_7_unc_pahfit = fltarr(n_elements(sl_cube(*,0,0)), n_elements(sl_cube(0,*,0)))

for i=0,x,1 do begin
for j=0,y,1 do begin

;for i=6,7,1 do begin
;for j=51,52,1 do begin

fit=pahfit(wave, sl_cube(i,j,*), sl_unc(i,j,*), REDSHIFT=z,/_EXTRA, /WEIGHTS, /PLOT_PROGRESS, XSIZE=1000, YSIZE=600)

print, "i = ", i
print, "j = ", j

fit_cube[i,j,*]    = fit.final_fit
line_strengths     = fit.lines.int_strength
line_fwhm          = fit.lines.fwhm 
line_strengths_unc = fit.lines.int_strength_unc 
ew                 = fit.lines.eqw
dust_feature       = fit.dust_features.int_strength
dust_feature_fwhm  = fit.dust_features.fwhm
dust_feature_unc   = fit.dust_features.int_strength_unc
chi_squared        = fit.reduced_chi_sq
beta               = fit.extinction.beta
beta_unc           = fit.extinction.beta_unc
tau_9_7            = fit.extinction.tau_9_7
tau_9_7_unc        = fit.extinction.tau_9_7_unc

;Reconstruct the continuum fit
stars   = fit.starlight.tau*pahfit_blackbody_nu(wave, fit.starlight.temperature)
dc_pars = fit.dust_continuum
for k=0,n_elements(dc_pars)-1 do begin
    this_dc = dc_pars[k].tau*(9.7D/wave)^2* $
              pahfit_blackbody_nu(wave,dc_pars[k].temperature)
    if k eq 0 then dc_tot=this_dc else dc_tot+=this_dc
endfor
tot_cont = dc_tot+stars
continuum_fit =tot_cont
extinction = pahfit_tau(wave,fit.extinction.beta, $
                          CHIAR_TIELENS=fit.extinction.type eq 1, $
                          KEMPER_VRIEND_TIELENS=fit.extinction.type eq 0)

ext=pahfit_extinction(wave,fit.extinction.tau_9_7,extinction, $
                        SCREEN=fit.extinction.screen)

continuum_fit = ext*continuum_fit
;plot, wave, fit.final_fit/wave, xrange=[5,15]
;oplot, wave, continuum_fit
cont_fit[i,j,*]   = continuum_fit

;Line strength arrays
H2_s7[i,j] = line_strengths[0]
H2_s6[i,j] = line_strengths[1]
H2_s5[i,j] = line_strengths[2]
ArII[i,j]  = line_strengths[3]
H2_s4[i,j] = line_strengths[4]
ArIII[i,j] = line_strengths[5]
H2_s3[i,j] = line_strengths[6]
SIV[i,j]   = line_strengths[7]
H2_s2[i,j] = line_strengths[8]
NeII[i,j]  = line_strengths[9]

;Equivalent width arrays
ew_H2_s7[i,j] = ew[0]
ew_H2_s6[i,j] = ew[1]
ew_H2_s5[i,j] = ew[2]
ew_ArII[i,j]  = ew[3]
ew_H2_s4[i,j] = ew[4]
ew_ArIII[i,j] = ew[5]
ew_H2_s3[i,j] = ew[6]
ew_SIV[i,j]   = ew[7]
ew_H2_s2[i,j] = ew[8]
ew_NeII[i,j]  = ew[9]

;Line FWHM strength arrays
H2_s7_fwhm[i,j]  = line_fwhm[0]
H2_s6_fwhm[i,j]  = line_fwhm[1]
H2_s5_fwhm[i,j]  = line_fwhm[2]
ArII_fwhm[i,j]   = line_fwhm[3]
H2_s4_fwhm[i,j]  = line_fwhm[4]
ArIII_fwhm[i,j]  = line_fwhm[5]
H2_s3_fwhm[i,j]  = line_fwhm[6]
SIV_fwhm[i,j]    = line_fwhm[7]
H2_s2_fwhm[i,j]  = line_fwhm[8]
NeII_fwhm[i,j]   = line_fwhm[9]

;Line strength uncertaintys
H2_s7_unc[i,j] = line_strengths_unc[0]
H2_s6_unc[i,j] = line_strengths_unc[1]
H2_s5_unc[i,j] = line_strengths_unc[2]
ArII_unc[i,j]  = line_strengths_unc[3]
H2_s4_unc[i,j] = line_strengths_unc[4]
ArIII_unc[i,j] = line_strengths_unc[5]
H2_s3_unc[i,j] = line_strengths_unc[6]
SIV_unc[i,j]   = line_strengths_unc[7]
H2_s2_unc[i,j] = line_strengths_unc[8]
NeII_unc[i,j]  = line_strengths_unc[9]

;Initialize Dust Feature Arrays
df_14_1_micron[i,j] = dust_feature[17]
df_14_0_micron[i,j] = dust_feature[16]
df_13_5_micron[i,j] = dust_feature[15]
df_12_7_micron[i,j] = dust_feature[14]
df_12_6_micron[i,j] = dust_feature[13]
df_12_micron[i,j]   = dust_feature[12]
df_11_3_micron[i,j] = dust_feature[11]
df_11_2_micron[i,j] = dust_feature[10]
df_10_7_micron[i,j] = dust_feature[9]
df_8_6_micron[i,j]  = dust_feature[8]
df_8_3_micron[i,j]  = dust_feature[7]
df_7_8_micron[i,j]  = dust_feature[6]
df_7_6_micron[i,j]  = dust_feature[5]
df_7_4_micron[i,j]  = dust_feature[4]
df_6_7_micron[i,j]  = dust_feature[3]
df_6_2_micron[i,j]  = dust_feature[2]
df_5_7_micron[i,j]  = dust_feature[1]
df_5_2_micron[i,j]  = dust_feature[0]

;Dust Feature FWHMs
df_14_1_micron_fwhm[i,j] = dust_feature_fwhm[17]
df_14_0_micron_fwhm[i,j] = dust_feature_fwhm[16]
df_13_5_micron_fwhm[i,j] = dust_feature_fwhm[15]
df_12_7_micron_fwhm[i,j] = dust_feature_fwhm[14]
df_12_6_micron_fwhm[i,j] = dust_feature_fwhm[13]
df_12_micron_fwhm[i,j]   = dust_feature_fwhm[12]
df_11_3_micron_fwhm[i,j] = dust_feature_fwhm[11]
df_11_2_micron_fwhm[i,j] = dust_feature_fwhm[10]
df_10_7_micron_fwhm[i,j] = dust_feature_fwhm[9]
df_8_6_micron_fwhm[i,j]  = dust_feature_fwhm[8]
df_8_3_micron_fwhm[i,j]  = dust_feature_fwhm[7]
df_7_8_micron_fwhm[i,j]  = dust_feature_fwhm[6]
df_7_6_micron_fwhm[i,j]  = dust_feature_fwhm[5]
df_7_4_micron_fwhm[i,j]  = dust_feature_fwhm[4]
df_6_7_micron_fwhm[i,j]  = dust_feature_fwhm[3]
df_6_2_micron_fwhm[i,j]  = dust_feature_fwhm[2]
df_5_7_micron_fwhm[i,j]  = dust_feature_fwhm[1]
df_5_2_micron_fwhm[i,j]  = dust_feature_fwhm[0]

;Initialize Dust Feature Uncertainty Arrays
df_14_1_micron_unc[i,j] = dust_feature_unc[17]
df_14_0_micron_unc[i,j] = dust_feature_unc[16]
df_13_5_micron_unc[i,j] = dust_feature_unc[15]
df_12_7_micron_unc[i,j] = dust_feature_unc[14]
df_12_6_micron_unc[i,j] = dust_feature_unc[13]
df_12_micron_unc[i,j]   = dust_feature_unc[12]
df_11_3_micron_unc[i,j] = dust_feature_unc[11]
df_11_2_micron_unc[i,j] = dust_feature_unc[10]
df_10_7_micron_unc[i,j] = dust_feature_unc[9]
df_8_6_micron_unc[i,j]  = dust_feature_unc[8]
df_8_3_micron_unc[i,j]  = dust_feature_unc[7]
df_7_8_micron_unc[i,j]  = dust_feature_unc[6]
df_7_6_micron_unc[i,j]  = dust_feature_unc[5]
df_7_4_micron_unc[i,j]  = dust_feature_unc[4]
df_6_7_micron_unc[i,j]  = dust_feature_unc[3]
df_6_2_micron_unc[i,j]  = dust_feature_unc[2]
df_5_7_micron_unc[i,j]  = dust_feature_unc[1]
df_5_2_micron_unc[i,j]  = dust_feature_unc[0]

;Chi Squared
chi_sq[i,j]    = chi_squared 

;Beta
beta_pahfit[i,j]     = beta
beta_unc_pahfit[i,j] = beta_unc

;Tau 9.7
tau_9_7_pahfit[i,j]     = tau_9_7
tau_9_7_unc_pahfit[i,j] = tau_9_7_unc


endfor

endfor
;END ALL LOOPS


;sl_crpix1 = sxpar(sl1_header, 'CRPIX1') ;Ref pix x
;sl_crpix2 = sxpar(sl1_header, 'CRPIX2') ;Ref pix y
;sl_cdelt1 = sxpar(sl1_header, 'CDELT1') ;Degree/Pix
;sl_cdelt2 = sxpar(sl1_header, 'CDELT2') ;Degree/Pix
sl_crval1_orig = sxpar(sl1_header, 'CRVAL1') ;RA
sl_crval2_orig = sxpar(sl1_header, 'CRVAL2') ;Dec

sl_crpix1 = 1
sl_crpix2 = 1
sl_cdelt1 = sxpar(sl1_header, 'CDELT1') ;Degree/Pix
sl_cdelt2 = sxpar(sl1_header, 'CDELT2') ;Degree/Pix
sl_crval1 = sl_crval1_orig - 0.047559476
sl_crval2 = sl_crval2_orig + 0.0306952601

hist = strarr(3)
hist[0] = 'PAHMAP'
hist[1] = 'This file was produced by running pahfit.pro over the joined SL IRS Spectral Cubes'
hist[2] = 'This is the PAHFIT CUBE'
sxaddhist, hist, sl1_header
sxdelpar, sl1_header, ['CRPIX1']
sxdelpar, sl1_header, ['CRPIX2']
sxdelpar, sl1_header, ['CRVAL1']
sxdelpar, sl1_header, ['CRVAL2']
sxdelpar, sl1_header, ['CDELT1']
sxdelpar, sl1_header, ['CDELT2']
sxaddpar, sl1_header, 'CRPIX1', sl_crpix1
sxaddpar, sl1_header, 'CRPIX2', sl_crpix2
sxaddpar, sl1_header, 'CRVAL1', sl_crval1
sxaddpar, sl1_header, 'CRVAL2', sl_crval2
sxaddpar, sl1_header, 'CDELT1', sl_cdelt1
sxaddpar, sl1_header, 'CDELT2', sl_cdelt2

;Update map headers
sl_header = sl1_header
map_hist = strarr(4)
map_hist[0] = 'PAHMAP'
map_hist[1] = 'This file was produced by running pahfit.pro' 
map_hist[2] = 'over the joined SL IRS Spectral Cubes'
map_hist[3] = 'This is the PAHFIT FEATURE MAP'
sxaddhist, map_hist, sl_header
sxdelpar, sl_header, ['NAXIS3']
sxaddpar, sl_header, 'NAXIS', 2
sxdelpar, sl_header, ['CRPIX1']
sxdelpar, sl_header, ['CRPIX2']
sxdelpar, sl_header, ['CRVAL1']
sxdelpar, sl_header, ['CRVAL2']
sxdelpar, sl_header, ['CDELT1']
sxdelpar, sl_header, ['CDELT2']
sxaddpar, sl_header, 'CRPIX1', sl_crpix1
sxaddpar, sl_header, 'CRPIX2', sl_crpix2
sxaddpar, sl_header, 'CRVAL1', sl_crval1
sxaddpar, sl_header, 'CRVAL2', sl_crval2
sxaddpar, sl_header, 'CDELT1', sl_cdelt1
sxaddpar, sl_header, 'CDELT2', sl_cdelt2


;Write Cubes
residual_cube = new_cube - fit_cube
cont_sub_cube = fit_cube - cont_fit
mwrfits, new_cube, 'sl_cube_smooth.fits',sl1_header
mwrfits, new_unc, 'sl_unc_smooth.fits',sl1_header
mwrfits, old_cube, 'sl_cube.fits', sl1_header
mwrfits, old_unc, 'sl_unc.fits', sl1_header 
mwrfits, fit_cube, 'sl_pahfit_cube.fits', sl1_header
mwrfits, cont_fit, 'sl_pahfit_continuum_fit_cube.fits', sl1_header
mwrfits, residual_cube, 'sl_residual_cube.fits', sl1_header
mwrfits, cont_sub_cube, 'sl_pahfit_cont_sub_cube.fits', sl1_header

;Write Maps
mwrfits, H2_s7, 'H5_map.fits', sl_header
mwrfits, H2_s6, 'H5_5_map.fits', sl_header
mwrfits, H2_s5, 'H7_map.fits', sl_header
mwrfits, ArII, 'ArII_map.fits', sl_header
mwrfits, H2_s4, 'H8_map.fits', sl_header
mwrfits, ArIII, 'ArIII_map.fits', sl_header
mwrfits, H2_s3, 'H9_map.fits', sl_header
mwrfits, SIV, 'SIV_map.fits', sl_header
mwrfits, H2_s2, 'H12_map.fits', sl_header
mwrfits, NeII, 'NeII_map.fits', sl_header

;Line FWHM Maps
mwrfits, H2_s7_fwhm, 'H5_fwhm_map.fits', sl_header
mwrfits, H2_s6_fwhm, 'H5_5_fwhm_map.fits', sl_header
mwrfits, H2_s5_fwhm, 'H7_fwhm_map.fits', sl_header
mwrfits, ArII_fwhm, 'ArII_fwhm_map.fits', sl_header
mwrfits, H2_s4_fwhm, 'H8_fwhm_map.fits', sl_header
mwrfits, ArIII_fwhm, 'ArIII_fwhm_map.fits', sl_header
mwrfits, H2_s3_fwhm, 'H9_fwhm_map.fits', sl_header
mwrfits, SIV_fwhm, 'SIV_fwhm_map.fits', sl_header
mwrfits, H2_s2_fwhm, 'H12_fwhm_map.fits', sl_header
mwrfits, NeII_fwhm, 'NeII_fwhm_map.fits', sl_header

;Equivalent width maps
mwrfits, ew_H2_s7, 'H5_ew_map.fits',sl_header
mwrfits, ew_H2_s6, 'H5_5_ew_map.fits',sl_header
mwrfits, ew_H2_s5, 'H7_ew_map.fits',sl_header
mwrfits, ew_ArII, 'ArII_ew_map.fits',sl_header
mwrfits, ew_H2_s4, 'H8_ew_map.fits',sl_header
mwrfits, ew_ArIII, 'ArIII_ew_map.fits',sl_header
mwrfits, ew_H2_s3, 'H9_ew_map.fits',sl_header
mwrfits, ew_SIV, 'SIV_ew_map.fits',sl_header
mwrfits, ew_H2_s2, 'H12_ew_map.fits',sl_header
mwrfits, ew_NeII, 'NeII_ew_map.fits',sl_header

;Line strength uncertainty maps
mwrfits, H2_s7_unc, 'H5_map_unc.fits', sl_header
mwrfits, H2_s6_unc, 'H5_5_map_unc.fits', sl_header
mwrfits, H2_s5_unc, 'H7_map_unc.fits', sl_header
mwrfits, ArII_unc, 'ArII_map_unc.fits', sl_header
mwrfits, H2_s4_unc, 'H8_map_unc.fits', sl_header
mwrfits, ArIII_unc, 'ArIII_map_unc.fits', sl_header
mwrfits, H2_s3_unc, 'H9_map_unc.fits', sl_header
mwrfits, SIV_unc, 'SIV_map_unc.fits', sl_header
mwrfits, H2_s2_unc, 'H12_map_unc.fits', sl_header
mwrfits, NeII_unc, 'NeII_map_unc.fits', sl_header

;Dust Feature Maps
mwrfits, df_14_1_micron, 'df_14_1_micron_dust_feature.fits', sl_header
mwrfits, df_14_0_micron, 'df_14_0_micron_dust_feature.fits', sl_header
mwrfits, df_13_5_micron, 'df_13_5_micron_dust_feature.fits', sl_header
mwrfits, df_12_7_micron, 'df_12_7_micron_dust_feature.fits', sl_header
mwrfits, df_12_6_micron, 'df_12_6_micron_dust_feature.fits', sl_header
mwrfits, df_12_micron, 'df_12_micron_dust_feature.fits', sl_header
mwrfits, df_11_3_micron, 'df_11_3_micron_dust_feature.fits', sl_header
mwrfits, df_11_2_micron, 'df_11_2_micron_dust_feature.fits', sl_header
mwrfits, df_10_7_micron, 'df_10_7_micron_dust_feature.fits', sl_header
mwrfits, df_8_6_micron, 'df_8_6_micron_dust_feature.fits', sl_header
mwrfits, df_8_3_micron, 'df_8_3_micron_dust_feature.fits', sl_header
mwrfits, df_7_8_micron, 'df_7_8_micron_dust_feature.fits', sl_header
mwrfits, df_7_6_micron, 'df_7_6_micron_dust_feature.fits', sl_header
mwrfits, df_7_4_micron, 'df_7_4_micron_dust_feature.fits', sl_header
mwrfits, df_6_7_micron, 'df_6_7_micron_dust_feature.fits', sl_header
mwrfits, df_6_2_micron, 'df_6_2_micron_dust_feature.fits', sl_header
mwrfits, df_5_7_micron, 'df_5_7_micron_dust_feature.fits', sl_header
mwrfits, df_5_2_micron, 'df_5_2_micron_dust_feature.fits', sl_header

;Dust Feature Uncertainty Maps
mwrfits, df_14_1_micron_unc, 'df_14_1_micron_dust_feature_unc.fits', sl_header
mwrfits, df_14_0_micron_unc, 'df_14_0_micron_dust_feature_unc.fits', sl_header
mwrfits, df_13_5_micron_unc, 'df_13_5_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_7_micron_unc, 'df_12_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_6_micron_unc, 'df_12_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_12_micron_unc, 'df_12_micron_dust_feature_unc.fits', sl_header
mwrfits, df_11_3_micron_unc, 'df_11_3_micron_dust_feature_unc.fits', sl_header
mwrfits, df_11_2_micron_unc, 'df_11_2_micron_dust_feature_unc.fits', sl_header
mwrfits, df_10_7_micron_unc, 'df_10_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_8_6_micron_unc, 'df_8_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_8_3_micron_unc, 'df_8_3_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_8_micron_unc, 'df_7_8_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_6_micron_unc, 'df_7_6_micron_dust_feature_unc.fits', sl_header
mwrfits, df_7_4_micron_unc, 'df_7_4_micron_dust_feature_unc.fits', sl_header
mwrfits, df_6_7_micron_unc, 'df_6_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_6_2_micron_unc, 'df_6_2_micron_dust_feature_unc.fits', sl_header
mwrfits, df_5_7_micron_unc, 'df_5_7_micron_dust_feature_unc.fits', sl_header
mwrfits, df_5_2_micron_unc, 'df_5_2_micron_dust_feature_unc.fits', sl_header

;Dust Feature FWHM
mwrfits, df_14_1_micron_fwhm, 'df_14_1_micron_fwhm.fits', sl_header
mwrfits, df_14_0_micron_fwhm, 'df_14_0_micron_fwhm.fits', sl_header
mwrfits, df_13_5_micron_fwhm, 'df_13_5_micron_fwhm.fits', sl_header
mwrfits, df_12_7_micron_fwhm, 'df_12_7_micron_fwhm.fits', sl_header
mwrfits, df_12_6_micron_fwhm, 'df_12_6_micron_fwhm.fits', sl_header
mwrfits, df_12_micron_fwhm, 'df_12_micron_fwhm.fits', sl_header
mwrfits, df_11_3_micron_fwhm, 'df_11_3_micron_fwhm.fits', sl_header
mwrfits, df_11_2_micron_fwhm, 'df_11_2_micron_fwhm.fits', sl_header
mwrfits, df_10_7_micron_fwhm, 'df_10_7_micron_fwhm.fits', sl_header
mwrfits, df_8_6_micron_fwhm, 'df_8_6_micron_fwhm.fits', sl_header
mwrfits, df_8_3_micron_fwhm, 'df_8_3_micron_fwhm.fits', sl_header
mwrfits, df_7_8_micron_fwhm, 'df_7_8_micron_fwhm.fits', sl_header
mwrfits, df_7_6_micron_fwhm, 'df_7_6_micron_fwhm.fits', sl_header
mwrfits, df_7_4_micron_fwhm, 'df_7_4_micron_fwhm.fits', sl_header
mwrfits, df_6_7_micron_fwhm, 'df_6_7_micron_fwhm.fits', sl_header
mwrfits, df_6_2_micron_fwhm, 'df_6_2_micron_fwhm.fits', sl_header
mwrfits, df_5_7_micron_fwhm, 'df_5_7_micron_fwhm.fits', sl_header
mwrfits, df_5_2_micron_fwhm, 'df_5_2_micron_fwhm.fits', sl_header

;Chi Squared Maps
mwrfits, chi_sq, 'chi_squared_map.fits', sl_header

;Beta Maps
mwrfits, beta_pahfit,'Beta_map.fits', sl_header
mwrfits, beta_unc_pahfit, 'Beta_unc_map.fits', sl_header

;Tau 9.7 Maps
mwrfits, tau_9_7_pahfit,'Tau_9_7_map.fits', sl_header
mwrfits, tau_9_7_unc_pahfit, 'Tau_9_7_unc_map.fits', sl_header

end

