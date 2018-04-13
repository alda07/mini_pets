package com.sugarventures.alda.actionsheet;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by hanhvo on 3/30/18.
 */

public class MachinesAdapter extends ArrayAdapter<MachineData> implements View.OnClickListener
{
    private ArrayList<MachineData> dataSet;
    Context mContext;
    private int lastPosition = -1;


    private  static class ViewHolder {
        TextView machineName;
        TextView machineAddress;
        ImageView machineImage;
    }

    public MachinesAdapter(ArrayList<MachineData> data, Context context) {
        super(context, R.layout.ios_sheet_item,data);
        this.dataSet = data;
        this.mContext = context;
    }

    @Override
    public void onClick(View v) {

        int position = (Integer) v.getTag();
        Object object = getItem(position);
        MachineData machineData = (MachineData)object;

        switch (v.getId()) {
            case R.id.machine_name:
                Log.d(Integer.toString(position),machineData.getMachineName());
                break;
        }
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        MachineData machineData = getItem(position);

        ViewHolder viewHolder;

        final View result;

        if (convertView == null) {
            viewHolder = new ViewHolder();
            LayoutInflater infater = LayoutInflater.from(getContext());
            convertView = infater.inflate(R.layout.ios_sheet_item,parent,false);
            viewHolder.machineName = (TextView) convertView.findViewById(R.id.machine_name);
            viewHolder.machineAddress = (TextView) convertView.findViewById(R.id.machine_address);
            viewHolder.machineImage = (ImageView) convertView.findViewById(R.id.machine_image);

            result = convertView;
            convertView.setTag(viewHolder);
        }
        else
        {
            viewHolder = (ViewHolder) convertView.getTag();
            result = convertView;
        }

        viewHolder.machineName.setText(machineData.getMachineName());
        viewHolder.machineAddress.setText(machineData.getMachineAdress());

        viewHolder.machineImage.setOnClickListener(this);
        viewHolder.machineImage.setTag(position);

        return convertView;

    }
}
