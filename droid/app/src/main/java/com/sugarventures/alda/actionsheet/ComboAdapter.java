package com.sugarventures.alda.actionsheet;

import android.content.Context;
import android.graphics.Paint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.List;

public class ComboAdapter extends BaseAdapter {

    private static String mRemainingMessage = "Còn %d Sản Phẩm";
    private final Context mContext;
    private final List<MachineProductData> mProducts;

    public ComboAdapter(Context mContext, List<MachineProductData> mProducts) {
        this.mContext = mContext;
        this.mProducts = mProducts;
    }

    @Override
    public int getCount() {
        return mProducts.size();
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        //1: get product data
        final MachineProductData productData = mProducts.get(position);

        //2 : get children of layout product_item
        if (convertView == null) {
            final LayoutInflater layoutInflater = LayoutInflater.from(mContext);
            convertView = layoutInflater.inflate(R.layout.combo_item, null);
            final ImageView comboImageView = (ImageView)convertView.findViewById(R.id.combo_image);
            final TextView comboRemaining = (TextView) convertView.findViewById(R.id.combo_remaining);
            final TextView comboPrice = (TextView) convertView.findViewById(R.id.combo_price);
            final TextView comboDiscount = (TextView) convertView.findViewById(R.id.combo_discount);


            final ViewHolder viewHolder = new ViewHolder(comboImageView,comboRemaining,comboPrice,comboDiscount);
            convertView.setTag(viewHolder);

        }

        final ViewHolder viewHolder = (ViewHolder)convertView.getTag();

        //3: pull product data on children view
        Picasso.with(mContext)
                .load(productData.getUrlImage())
                .into(viewHolder.comboImage);

        viewHolder.comboRemaining.setText(String.format(mRemainingMessage,productData.getRemainingProduct()));
        viewHolder.comboPrice.setText(productData.getPrice());
        viewHolder.comboDiscount.setText(productData.getDiscountPrice());
        viewHolder.comboDiscount.setPaintFlags(Paint.STRIKE_THRU_TEXT_FLAG);

        return  convertView;
    }

    private class ViewHolder
    {
        private final ImageView comboImage;
        private final TextView comboRemaining;
        private final TextView comboPrice;
        private final TextView comboDiscount;

        public ViewHolder(ImageView comboImage, TextView comboRemaining, TextView comboPrice, TextView comboDiscount) {
            this.comboImage = comboImage;
            this.comboRemaining = comboRemaining;
            this.comboPrice = comboPrice;
            this.comboDiscount = comboDiscount;
        }
    }
}
