package com.example.springboot.controller;

import com.example.springboot.entity.Repair;
import com.example.springboot.service.RepairService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;

/**
 * @author xh
 * @Date 2023/6/13
 */
@Controller
public class NFCController {

    @Resource
    private RepairService repairService;

    /**
     * NFC保修
     */
    @GetMapping("/nfcRepair")
    public String nfcRepair(@RequestParam String deviceId, Model model) {
        Repair repair =  repairService.nfcRepair(deviceId);
        model.addAttribute("repair", repair);
        if(repair != null) {
            return "success";
        } else {
            return "fail";
        }
    }

}
