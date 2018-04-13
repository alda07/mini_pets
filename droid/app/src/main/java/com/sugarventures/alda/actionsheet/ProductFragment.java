package com.sugarventures.alda.actionsheet;

// Create floating button
// Get support library for androi
// URL : https://developer.android.com/topic/libraries/support-library/setup.html

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.GridView;

import java.util.ArrayList;
import java.util.List;

public class ProductFragment extends Fragment {

    private static final String TAG = "PRODUCT_TAG";
    private Context mContext;
    private List<MachineProductData>products;
    private ProductsAdapter productsAdapter;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {

        mContext = container.getContext();
        View view = inflater.inflate(R.layout.fragment_products,container, false);

        // For Product Grid
        String sampleImage = "https://d2wvksc3i53c0p.cloudfront.net/media/catalog/product/optimized/2/0/203f96f71d36fc598c5c12ebc3bb2318/p96120b.jpg";

        MachineProductData p1 = new MachineProductData(sampleImage, 10);
        MachineProductData p2 = new MachineProductData(sampleImage, 10);
        MachineProductData p3 = new MachineProductData(sampleImage, 10);
        MachineProductData p4 = new MachineProductData(sampleImage, 10);
        MachineProductData p5 = new MachineProductData(sampleImage, 10);
        MachineProductData p6 = new MachineProductData(sampleImage, 10);
        MachineProductData p7 = new MachineProductData(sampleImage, 10);
        MachineProductData p8 = new MachineProductData(sampleImage, 10);
        MachineProductData p9 = new MachineProductData(sampleImage, 10);
        MachineProductData p10 = new MachineProductData(sampleImage, 10);

        products = new ArrayList<>();
        products.add(p1);
        products.add(p2);
        products.add(p3);
        products.add(p4);
        products.add(p5);
        products.add(p6);
        products.add(p7);
        products.add(p8);
        products.add(p9);
        products.add(p10);


        productsAdapter = new ProductsAdapter(mContext,products);

        GridView gridView = (GridView)(view.findViewById(R.id.grid_products));
        gridView.setAdapter(productsAdapter);
        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                // This tells the GridView to redraw itself
                    // in turn calling ProductAdapter's getView method again for each
                productsAdapter.notifyDataSetChanged();
            }
        });

        // for floating button
        FloatingActionButton btnFilter = (FloatingActionButton)view.findViewById(R.id.btnFilter);
        btnFilter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

        return view;
    }
}
