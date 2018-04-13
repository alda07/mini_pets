package com.sugarventures.alda.actionsheet;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.GridView;

import java.util.ArrayList;
import java.util.List;

public class ComboFragment extends Fragment {

    private static String TAG = "COMBO_TAG";
    private Context mContext;
    private List<MachineProductData> comboProducts;
    private ComboAdapter comboAdapter;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        mContext = container.getContext();

        View view = inflater.inflate(R.layout.fragment_combo,container, false);
        // For Product Grid
        String sampleImage = "https://d2wvksc3i53c0p.cloudfront.net/media/catalog/product/optimized/2/0/203f96f71d36fc598c5c12ebc3bb2318/p96120b.jpg";

        MachineProductData p1 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p2 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p3 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p4 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p5 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p6 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p7 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p8 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p9 = new MachineProductData(sampleImage, 10, "20.000","10.000");
        MachineProductData p10 = new MachineProductData(sampleImage, 10, "20.000","10.000");

        comboProducts = new ArrayList<>();
        comboProducts.add(p1);
        comboProducts.add(p2);
        comboProducts.add(p3);
        comboProducts.add(p4);
        comboProducts.add(p5);
        comboProducts.add(p6);
        comboProducts.add(p7);
        comboProducts.add(p8);
        comboProducts.add(p9);
        comboProducts.add(p10);


        comboAdapter = new ComboAdapter(mContext,comboProducts);

        GridView gridView = (GridView)(view.findViewById(R.id.grid_combos));
        gridView.setAdapter(comboAdapter);
        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                // This tells the GridView to redraw itself
                // in turn calling ProductAdapter's getView method again for each
                comboAdapter.notifyDataSetChanged();
            }
        });

        return  view;
    }
}
