using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Midtrans.RNMidtrans
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNMidtransModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNMidtransModule"/>.
        /// </summary>
        internal RNMidtransModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNMidtrans";
            }
        }
    }
}
