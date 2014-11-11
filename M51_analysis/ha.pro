ha = mrdfits('ngc5194_HA_dr4.fits', 0, ha_header)
cold = mrdfits('cold_mass_contour_plot.fits', 0, cold_header)
warm = mrdfits('warm_mass_contour_plot.fits', 0, warm_header)
hastrom, cold, cold_header, ha_header, MISSING=0
hastrom, warm, warm_header, ha_header, MISSING=0
mwrfits, cold, 'ha_v_cold.fits', ha_header
mwrfits, warm, 'ha_v_warm.fits', ha_header
end
