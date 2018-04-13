package com.sugarventures.alda.actionsheet;

/**
 * Created by hanhvo on 3/30/18.
 */

public class MachineData {
    String machineName;
    String machineAdress;

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public String getMachineAdress() {
        return machineAdress;
    }

    public void setMachineAdress(String machineAdress) {
        this.machineAdress = machineAdress;
    }

    public MachineData(String machineName, String machineAdress) {
        this.machineName = machineName;
        this.machineAdress = machineAdress;
    }
}
