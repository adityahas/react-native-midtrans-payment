package com.adityahas.midtrans;

import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback;
import com.midtrans.sdk.corekit.models.snap.TransactionResult;

/**
 * Created by AlSahfer on 23/11/17.
 */

public class TransactionCallback implements TransactionFinishedCallback {

    Callback callback;

    TransactionCallback(Callback callback) {
        this.callback = callback;
    }

    @Override
    public void onTransactionFinished(TransactionResult transactionResult) {
        // temporary fix for gopay pending status
        if (transactionResult.isTransactionCanceled() || (transactionResult.getResponse().getPaymentType().equals("gopay") && transactionResult.getStatus().equals("pending"))) {
            this.callback.invoke("cancelled");
        } else {
            this.callback.invoke(transactionResult.getStatus());
        }

        Log.d("result", transactionResult.getStatus());
    }
}
