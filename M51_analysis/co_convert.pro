co = mrdfits('NGC5194mom0h.fits', 0, co_header)
d = 9.6
m = (1.36*1.1*10^4)*co*d^2*(5.43/41800)
mwrfits, m, 'NGC5194mom0h_mass_density.fits', co_header

end
