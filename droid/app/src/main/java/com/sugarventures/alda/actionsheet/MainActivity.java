package com.sugarventures.alda.actionsheet;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * Created by hanhvo on 3/30/18.
 */

public class MainActivity extends AppCompatActivity {
    ArrayList<MachineData> dataModels;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        dataModels = new ArrayList<>();

        dataModels.add(new MachineData("M-01", "45 Vo Thi Sau Quan 1"));
        dataModels.add(new MachineData("M-02", "45 Vo Thi Sau Quan 1"));
        dataModels.add(new MachineData("M-03", "45 Vo Thi Sau Quan 1"));
        dataModels.add(new MachineData("M-04", "45 Vo Thi Sau Quan 1"));

        Button button = findViewById(R.id.btnActionsheet);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                MachineSheetDialog dialog2 = new MachineSheetDialog.Builder(MainActivity.this)
                        .setData(dataModels, new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog,
                                                int which) {
                                // dialog.dismiss();
                                Toast.makeText(getApplicationContext(),
                                        Integer.toString(which), Toast.LENGTH_LONG).show();
                            }})
                        .show();

            }
        });

        Button btnTab = findViewById(R.id.btnTabbar);
        btnTab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(MainActivity.this, ProductsActivity.class);
                startActivity(intent);

            }
        });

    }

}


