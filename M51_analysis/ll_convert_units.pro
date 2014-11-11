pro ll_convert_units, a, b
a = readfits(a,1,header)
a = a*25.8064/(4.25e10)
writefits, b, a, header
end
