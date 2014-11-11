pro sl_convert_units, a, b
a = readfits(a,1,header)
a = a*3.42250/(4.25e10)
writefits, b, a, header
end
