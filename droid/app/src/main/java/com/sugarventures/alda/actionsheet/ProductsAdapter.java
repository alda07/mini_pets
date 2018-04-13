package com.sugarventures.alda.actionsheet;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.List;

public class ProductsAdapter extends BaseAdapter {

    private static String mRemainingMessage = "Còn %d Sản Phẩm";
    private final Context mContext;
    private final List<MachineProductData> mProducts;

    public ProductsAdapter(Context mContext, List<MachineProductData> mProduct) {
        this.mContext = mContext;
        this.mProducts = mProduct;
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
            convertView = layoutInflater.inflate(R.layout.product_item, null);
            final ImageView productImageView = (ImageView)convertView.findViewById(R.id.product_image);
            final TextView remainingProduct = (TextView) convertView.findViewById(R.id.remaining_product);

            final ViewHolder viewHolder = new ViewHolder(productImageView, remainingProduct);
            convertView.setTag(viewHolder);

        }

        final ViewHolder viewHolder = (ViewHolder)convertView.getTag();

        //3: pull product data on children view
        Picasso.with(mContext)
                .load(productData.getUrlImage())
                .into(viewHolder.productImage);

        viewHolder.remainingProduct.setText(String.format(mRemainingMessage,productData.getRemainingProduct()));

        return  convertView;
    }

    private class ViewHolder {
        private final ImageView productImage;
        private final TextView remainingProduct;

        public ViewHolder(ImageView productImage, TextView remainingProduct) {
            this.productImage = productImage;
            this.remainingProduct = remainingProduct;
        }
    }
}
