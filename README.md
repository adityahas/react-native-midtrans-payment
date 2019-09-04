
# react-native-midtrans

## Getting started

`$ npm install react-native-midtrans --save`

### Mostly automatic installation

`$ react-native link react-native-midtrans`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-midtrans` and add `RNMidtrans.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNMidtrans.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNMidtransPackage;` to the imports at the top of the file
  - Add `new RNMidtransPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-midtrans'
  	project(':react-native-midtrans').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-midtrans/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-midtrans')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNMidtrans.sln` in `node_modules/react-native-midtrans/windows/RNMidtrans.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Midtrans.RNMidtrans;` to the usings at the top of the file
  - Add `new RNMidtransPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNMidtrans from 'react-native-midtrans';

// TODO: What to do with the module?
RNMidtrans;
```
  