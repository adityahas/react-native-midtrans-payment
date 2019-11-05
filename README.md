# react-native-midtrans-payment

Midtrans payment gateway forked from 'https://github.com/mfachmirizal/react-native-midtrans-payment-gateway' with improved callbacks for cancelled transactions.

## Getting started

`$ npm install react-native-midtrans-payment --save`

### Mostly automatic installation

`$ react-native link react-native-midtrans-payment`

### Manual installation

#### iOS

change Podfile into this or lastest version

#### pod 'MidtransCoreKit', '~> 1.14.3'

#### pod 'MidtransKit', '~> 1.14.3'

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-midtrans-payment` and add `RNMidtrans.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNMidtrans.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Whitelist the support apps like Gojek by adding bellow value on Info.plist
  `<key>LSApplicationQueriesSchemes</key>
  <array>
    <string>gojek</string>
  </array>`
5. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`

-   Add `import com.adityahas.midtrans.RNMidtransPackage;` to the imports at the top of the file
-   Add `new RNMidtransPackage()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:
    ```
    include ':react-native-midtrans-payment'
    project(':react-native-midtrans-payment').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-midtrans-payment/android')
    ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:

    ```
      compile project(':react-native-midtrans-payment')
    ```

4. Append midtrans repository to application level build.gradle
    ```
    maven { url "http://dl.bintray.com/pt-midtrans/maven" }
    maven { url "https://jitpack.io" }
    ```

## Usage

```javascript
import PaymentGateway from 'react-native-midtrans-payment';

async pay(){
        const optionConnect = {
            clientKey: "your client key",
            urlMerchant: "https://domain.net/", // will hit https://domain.net/charge
            sandbox : true, // works on iOS only, change it to false on production
        }

        const transRequest = {
            transactionId: "0001",
            totalAmount: 4000
        }

        const itemDetails = [
            {id: "001", price: 1000, qty: 4, name: "peanuts"}
        ];

        const creditCardOptions = {
            saveCard: false,
            saveToken: false,
            paymentMode: "Normal",
            secure: false
        };

        const userDetail = {
            fullName: "jhon",
            email: "jhon@payment.com",
            phoneNumber: "0850000000",
            userId: "U01",
            address: "street coffee",
            city: "yogyakarta",
            country: "IDN", <-- must be standard country code
            zipCode: "59382"
        };

        const optionColorTheme = {
            primary: '#c51f1f',
            primaryDark: '#1a4794',
            secondary: '#1fce38'
        }

        const optionFont = {
            defaultText: "open_sans_regular.ttf",
            semiBoldText: "open_sans_semibold.ttf",
            boldText: "open_sans_bold.ttf"
        }

        const callback = (res) => {
            console.log(res)
        };

        PaymentGateway.checkOut(
            optionConnect,
            transRequest,
            itemDetails,
            creditCardOptions,
            userDetail,
            optionColorTheme,
            optionFont,
            callback
        );
    }
```
