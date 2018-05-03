#!/bin/sh
## Fancy Info Box ###########################################################
# Whenever I buy a new album (which is not very frequent), I immediately    #
# rip to FLAC so I can have a lossless backup in case something bad happens #
# to the CD. When I wrote this script, I found that I did not enough space  #
# on my portable media player for another FLAC album. In an effort to       #
# squeeze in that one extra album, I wrote this scriptto enable every       #
# possible option for reducing the size of the encoded files. It was        #
# successful, having saved me those few precious megabytes I needed to      #
# store that one extra album. This script can't perform miracles in space-  #
# saving, but it should hopefully make a dent in the storage requirements   #
# of your collection. And no, you won't lose any quality: what you put in   #
# is exactly what you'll get back out (otherwise it wouldn't be called      #
# "lossless").                                                              #
#                                                                           #
# There are two ways to use this script (replace "variables" and paths as   #
# needed):                                                                  #
#   - From within a directory containing a bunch of FLAC files:             #
#     $ cd ${flacdir}                                                       #
#     $ ~/bin/reflac.sh                                                     #
#   - From within a directory containing other diretories with FLAC files   #
#     $ cd ${musicdir}                                                      #
#     $ for dir in *; do pushd "${dir}"; ~/bin/reflac.sh; popd; done        #
#############################################################################

for f in *.flac
do
	flac \
		--verify \
		--best \
		--mid-side \
		--exhaustive-model-search \
		--qlp-coeff-precision-search \
		--max-lpc-order=12 \
		--rice-partition-order=6 \
		-A artlett \
		-A bartlett_hann \
		-A blackman \
		-A blackman_harris_4term_92db \
		-A connes \
		-A flattop \
		-A gauss\(0.1\) \
		-A gauss\(0.2\) \
		-A gauss\(0.3\) \
		-A gauss\(0.4\) \
		-A gauss\(0.5\) \
		-A hamming \
		-A hann \
		-A kaiser_bessel \
		-A nuttall \
		-A rectangle \
		-A triangle \
		-A tukey\(0.1\) \
		-A tukey\(0.2\) \
		-A tukey\(0.3\) \
		-A tukey\(0.4\) \
		-A tukey\(0.5\) \
		-A partial_tukey\(1\) \
		-A partial_tukey\(2\) \
		-A punchout_tukey\(1\) \
		-A punchout_tukey\(2\) \
		-A punchout_tukey\(3\) \
		-A welch \
		"${f}" \
		-o "${f}.new" && 
		rm -rf "${f}" && 
		mv "${f}.new" "${f}"
done
metaflac --add-replay-gain *.flac
metaflac --sort-padding *.flac
