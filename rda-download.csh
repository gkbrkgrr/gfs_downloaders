set opts = "-N"
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
  set cert_opt = "--no-check-certificate"
else
  set cert_opt = ""
endif

set filelist= ( \
  https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f000.grib2  \
  https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f003.grib2  \
  https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f006.grib2  \
  https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f009.grib2  \
)
while($#filelist > 0)
  set syscmd = "wget $cert_opt $opts $filelist[1]"
  echo "$syscmd ..."
  $syscmd
  shift filelist
end
