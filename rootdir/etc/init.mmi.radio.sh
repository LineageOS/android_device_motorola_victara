#!/system/bin/sh
#

# Update the multisim config based on Radio version
radio=`getprop ro.boot.radio`
case $radio in
	"0x5") # Dual SIM
		# Temporarily remove setting of this, force users
		# to manually set until device fully supports
		# setprop persist.multisim.config dsds
		;;
	*) # All others
		setprop persist.multisim.config ""
		;;
esac
