
readcol, 'll1_wave.tbl', ll1wave, ll1flux, ll1unc
readcol, 'll2_wave.tbl', ll2wave, ll2flux, ll2unc
set_plot, 'ps'
device, filename = 'LL_spec2.ps', /ENCAPSULATE
plot, ll1wave,ll1flux, xstyle=1,ystyle=1, xrange=[14,39], yrange=[5, 60], xtitle = 'Wavelength (!7l!3m)', ytitle = 'MJy/sr', title = 'M51 Spectrum across the Long-Low Strip'
oplot, ll2wave, ll2flux
ll1 = fltarr(n_elements(ll1wave))
ll2 = fltarr(n_elements(ll2wave))
ll1 = ll1+47.5
ll2 = ll2+45.5 
oplot, ll1wave, ll1
oplot, ll2wave, ll2
xyouts, 33.6, 34, '[SIII](33.4 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 35, 50, '[SiII](34.8 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 28.3, 20, 'H2 S(0)(28.2 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 26, 18, '[FeII](25.98 !7l!3m)/[OIV](25.89 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 18.8, 15, '[SIII](18.71 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 17.2, 18, 'PAH(17.0 !7l!3m)/H2 S(1)(17.0 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 16.6, 15, 'PAH(16.4 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 15.7, 10, '[NeIII](15.5 !7l!3m)',  ALIGNMENT = 0.1, ORIENTATION = 90
xyouts, 28, 48.5, 'LL1'
xyouts, 17, 46.5, 'LL2'
device, /close
set_plot, 'x'
;end

ll_wave = [ll2wave,ll1wave]
ll_flux = [ll2flux,ll1flux]
ll_unc = [ll2unc,ll1unc]

;end

;fit = pahfit(ll_wave, ll_flux, ll_unc, REDSHIFT = 0, /PLOT_PROGRESS, XSIZE = 1000, YSIZE = 600)

end
