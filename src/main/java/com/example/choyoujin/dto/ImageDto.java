package com.example.choyoujin.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ImageDto {
    private int imageId;
    private String name;
    private String type;
    private byte[] picByte;
    private String encoding; // 압축 해제한 이미지 파일

    public ImageDto(String name, String type, byte[] picByte) {
        this.name = name;
        this.type = type;
        this.picByte = picByte;
    }

    public ImageDto(int imageId, String name, String type, byte[] picByte) {
        this.imageId = imageId;
        this.name = name;
        this.type = type;
        this.picByte = picByte;
    }
}
