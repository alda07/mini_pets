package com.sugarventures.alda.actionsheet;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;


/**
 * Created by hanhvo on 3/30/18.
 */

public class MachineSheetDialog extends Dialog implements DialogInterface {

    public MachineSheetDialog(Context context) {
        super(context, R.style.ios_sheet_style);
    }

    public static class Builder {
        private MachineSheetDialog mMachineSheetDialog;
        private Context mContext;
        private CharSequence mCancelText;
        private ArrayList<MachineData>machines;
        private OnClickListener mOnClickListener;

        public ArrayList<MachineData> getMachines() {
            return machines;
        }

        public void setMachines(ArrayList<MachineData> machines) {
            this.machines = machines;
        }


        public Builder(Context context) {
            this.mContext = context;

            this.mCancelText = mContext.getText(R.string.iossheet_cancel);
        }


        public Builder setCancelText(CharSequence text) {
            this.mCancelText = text;
            return this;
        }

        public Builder setCancelText(int textId) {
            this.mCancelText = mContext.getText(textId);
            return this;
        }

        public Builder setData(ArrayList<MachineData>items, OnClickListener listener) {

            this.machines = new ArrayList<>(items);
            this.mOnClickListener = listener;
            return this;
        }


        public MachineSheetDialog create() {
            LayoutInflater inflater = LayoutInflater.from(mContext);
            View sheetView = inflater.inflate(R.layout.ios_sheet_dialog, null);
            mMachineSheetDialog = new MachineSheetDialog(mContext);


            LinearLayout message_layout = (LinearLayout) sheetView.findViewById(R.id.message_layout);
            Button btn_cancel = (Button) sheetView.findViewById(R.id.btn_cancel);


            for (int i = 0, len = machines.size(); i < len; i++) {

                MachineData machineData = machines.get(i);

                View itemView = inflater.inflate(R.layout.ios_sheet_item, message_layout, false);
                View vLine = (View) itemView.findViewById(R.id.machine_line);
                TextView tvMachineName = (TextView) itemView.findViewById(R.id.machine_name);
                TextView tvMachineAddress = (TextView) itemView.findViewById(R.id.machine_address);

                tvMachineName.setText(machineData.getMachineName());
                tvMachineAddress.setText(machineData.getMachineAdress());

                if (i == len -1 )
                {
                    vLine.setVisibility(View.INVISIBLE);
                }
                final int itemIndex = i;
                itemView.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        if(mOnClickListener != null) {
                            mOnClickListener.onClick(mMachineSheetDialog, itemIndex);
                        }
                        mMachineSheetDialog.dismiss();
                    }
                });

                message_layout.addView(itemView);
            }
            btn_cancel.setText(mCancelText);

            btn_cancel.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    mMachineSheetDialog.dismiss();
                }
            });


            WindowManager wm = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
            DisplayMetrics metrics = new DisplayMetrics();
            wm.getDefaultDisplay().getMetrics(metrics);


            Window window = mMachineSheetDialog.getWindow();
            window.setWindowAnimations(R.style.ios_sheet_anim);
            window.setBackgroundDrawableResource(android.R.color.transparent);
            WindowManager.LayoutParams wml = window.getAttributes();
            wml.width = metrics.widthPixels;
            wml.gravity = Gravity.BOTTOM;
            wml.y = 0;
            window.setAttributes(wml);
            sheetView.setMinimumWidth(metrics.widthPixels);


            ViewGroup.LayoutParams vgl = new ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT);
            int maxHeight = (int) (metrics.heightPixels * 0.7);

            sheetView.measure(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            int dialogMeasureHeight = sheetView.getMeasuredHeight();
            if(dialogMeasureHeight > maxHeight) {
                vgl.height = maxHeight;
            }
            mMachineSheetDialog.setContentView(sheetView, vgl);
            return mMachineSheetDialog;
        }

        public MachineSheetDialog show() {
            mMachineSheetDialog = create();
            mMachineSheetDialog.show();
            return mMachineSheetDialog;
        }
    }
}
