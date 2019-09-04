import { NativeModules } from 'react-native'

const { RNMidtrans } = NativeModules

export default {
	checkOut: function(
		optionConnect: ?object,
		transRequest: ?object,
		itemDetails: ?object,
		creditCardOptions: ?object,
		mapUserDetail: ?object,
		optionColorTheme: ?object,
		optionFont: ?object,
		resultCallback
	) {
		RNMidtrans.checkOut(optionConnect, transRequest, itemDetails, creditCardOptions, mapUserDetail, optionColorTheme, optionFont, resultCallback)
	},
}
