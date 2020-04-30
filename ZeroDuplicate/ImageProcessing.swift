//
//  ImageProcessing.swift
//  ZeroDuplicate
//
//  Created by trivalent on 13/02/19.
//  Copyright © 2019 trivalent. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
extension UIImage {
    func resizeImage(_ newSize: CGSize) -> UIImage? {
        func isSameSize(_ newSize: CGSize) -> Bool {
            return size == newSize
        }
        
        func scaleImage(_ newSize: CGSize) -> UIImage? {
            func getScaledRect(_ newSize: CGSize) -> CGRect {
                return CGRect(x: 0, y: 0, width: 128, height: 128)
            }
            
            func _scaleImage(_ scaledRect: CGRect) -> UIImage? {
                UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
                draw(in: scaledRect)
                let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                return image
            }
            return _scaleImage(getScaledRect(newSize))
        }
        
        return isSameSize(newSize) ? self : scaleImage(newSize)!
    }
}

public class TWaveletPoint {
    public var X: Int = 0
    public var Y: Int = 0
    
    init() {
        self.X = 0
        self.Y = 0
        
    }
}

extension UIImage {
    func pixelData() -> [Int32]? {
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [Int32](repeating: 0, count: 16384)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return pixelData
    }
    
}
extension UIImage {
    
    
    
    func getPixelColor (x: Int, y: Int) -> Float{//UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return -1000//nil
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) //* numberOfComponents
        
        let r = CGFloat(data![pixelData]) /// 255.0
        let g = CGFloat(data![pixelData + 1])// / 255.0
        let b = CGFloat(data![pixelData + 2])// / 255.0
        let a = CGFloat(data![pixelData + 3])// / 255.0
        let greyColor:Float = (0.3 * Float(r)) + (0.59 * Float(g)) + (0.11 * Float(b))//Int32((0.3 * Float(r)) + (0.59 * Float(g)) + (0.11 * Float(b)));
      //  print("Color = \(x),\(y), red = \(r), green = \(g) blue = \(b), alpha = \(a)")
        //print("Gray Color: \(greyColor)")
        return greyColor//UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
//extension Data {
//    var bytes : [Int32]{
//        return [Int32](self)
//    }
//}
extension Data {
    var uint32: [UInt32] {
        get {
            let i32array = self.withUnsafeBytes {
                UnsafeBufferPointer<UInt32>(start: $0, count: self.count/2).map(UInt32.init(littleEndian:))
            }
            return i32array
        }
    }
}
extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}


class ImageProcessing {
    
   
    
    //    var imageData = UnsafeMutablePointer<UInt8>.allocate(capacity: 128*128)
    //static let pixelCount:Int = 128 * 128
    static let waveletMatrixA = [[Double]](repeating: [Double](repeating: 0, count: 128), count: 128)
    static let waveletMatrixB = [[Double]](repeating: [Double](repeating: 0, count: 128), count: 128)
    static var pixelsA:[Int8] = [Int8](repeating: 0, count: 16384)//[16384]
    static var pixelsB:[Int8] = [Int8](repeating: 0, count: 16384)//[16384]
    static let decompositionArray:[Double] = [Double](repeating: 0, count: 128)//[128]
    //static let coeff:[Double] = [Double](repeating: 0, count: 128)//[128]
    static let imageWidth = 128;
    static let imageHeight = 128;
    static let WaveletCoefsNumber:Int = 200
    static var coeff = [Double](repeating: 0, count: 16384)
    
    
//    static func convertToGreyScale(_ imageData: UIImage, _ outPtr: inout [Int32]) {
//
//        var pixels = [Int32](repeating: 0, count: 16384)
//        if let pix = imageData.pixelData(){
//            pixels = pix
//        }
//       print("pixels")
//        for j in 0...imageHeight-1 {
//            for i in 0...imageWidth - 1 {
//
//                let p = pixels[i + (j * imageWidth)];
//                let color = imageData.getPixelColor(x: j, y: i)
//               // if(color != -1000){
//                   // outPtr[i + (j * imageWidth)] = imageData.getPixelColor(x: j, y: i)
//
//                    let pixelInfo: Int = ((128 * j) + i) * 4
//                    print("pixelInfo: \(pixelInfo)")
//              //  }
//               // if((pixelInfo + 3) < imageData.count){
////                    let red = imageData[pixelInfo]
////                    let green = imageData[pixelInfo+1]
////                    let blue = imageData[pixelInfo+2]
////                    let alpha = imageData[pixelInfo+3]
//                    ///print("Color = \(pixelInfo), red = \(color), green = \(green) blue = \(blue), alpha = \(alpha)")
//                    //let greyColor = Int32((0.3 * Float(red)) + (0.59 * Float(green)) + (0.11 * Float(blue)));
//
//                var float1 : Float = imageData.getPixelColor(x: j, y: i)
//                //let data = Data(buffer: UnsafeBufferPointer(start: &float1, count: 1))
//                print("value is \(Int32(float1.bitPattern))")
//                outPtr[i + (j * imageWidth)] = Int32(float1)//imageData.getPixelColor(x: j, y: i)
//               // }
//            }
//        }
//
//
//    }
    
    static func resizeCurrentImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let size = CGSize(width: 128, height: 128)
        
        return image.af_imageScaled(to: size)
        
        
    }

    
    static func getMatricesForImageData(image:UIImage, waveletCoeff: inout [[Double]], positiveCoeff: inout [TWaveletPoint],negativeCoeff : inout [TWaveletPoint]){
        
        
        let size = CGSize(width: 128, height: 128)
        if let resizeImage = self.resizeCurrentImage(image: image, newWidth: 128){//image.resizeImage(size){
           // print("TIME 3 \(Utilities.getStringFromDate())")
            self.convertToGreyScale(resizeImage,&self.pixelsB )
           // print("TIME 4 \(Utilities.getStringFromDate())")
            self.BlurGreyMedian(&self.pixelsB)
            //print("TIME 5 \(Utilities.getStringFromDate())")
            let averageColorB = self.getAverageColor(self.pixelsB)
           // print("TIME 6 \(Utilities.getStringFromDate())")
            //print("average Color: \(averageColorB)")
            self.getWaveLetMatrix(self.pixelsB, &waveletCoeff, averageColorB)
            //print("TIME 7 \(Utilities.getStringFromDate())")
            for i in 0 ..< self.WaveletCoefsNumber{
                positiveCoeff[i] = TWaveletPoint()
                negativeCoeff[i] = TWaveletPoint()
            }
            //print("TIME 8 \(Utilities.getStringFromDate())")
            self.getWaveletCoeffs(&waveletCoeff, &positiveCoeff, &negativeCoeff)
            //print("TIME 9 \(Utilities.getStringFromDate())")
            
        }
    }
    static func convertToGreyScale(_ imageData: UIImage, _ imageBytes: inout [Int8]) {
        
        var pixels = [Int32](repeating: 0, count: 16384)
        

        pixels = self.imagePixel(image: imageData)
        
        
        
        for j in (0...imageHeight-1).reversed() {
            for i in (0...imageWidth - 1).reversed() {
                
                let p: Int32 = pixels[((128 * j) + i)]
                
             
                let color = self.getUIColorFromAndroidColorInt(androidColorInt: p)
               
                
                var red:CGFloat = 0.0
                var green:CGFloat = 0.0
                var blue:CGFloat = 0.0
                var alpha:CGFloat = 0.0
                
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                
               
              
                
                
                let greyColor = (0.3 * Float(red)) + (0.59 * Float(green)) + (0.11 * Float(blue));
                let byte = Int8(truncating: NSNumber(value: greyColor))
               // let byteValue = ImageHelper.getbyteValue(greyColor)
                    imageBytes[i + (j * imageWidth)] = Int8(byte)//greyColor
                //}
            }
        }
        
        //print(outPtr)
        
    }
   static func getUIColorFromAndroidColorInt(androidColorInt: Int32) -> UIColor {
        
//    let red = (CGFloat) ( (androidColorInt>>16)&0xFF )
//        let green = (CGFloat) ( (androidColorInt>>8)&0xFF )
//        let blue = (CGFloat) ( (androidColorInt)&0xFF )
    
    return UIColor(red: (CGFloat((androidColorInt >> 16) & 0xff)), green: (CGFloat((androidColorInt >> 8) & 0xff)), blue: (CGFloat((androidColorInt) & 0xff)), alpha: 1)
        
    }
    
    
//    static func convertToGreyScale(_ imageData: Data, _ outPtr: inout [Int32]) {
//
//        var pixels = [Int](repeating: 0, count: (imageHeight * imageWidth))
//
//        for j in 0...imageHeight-1 {
//            for i in 0...imageWidth - 1 {
//                let pixelInfo: Int = ((128 * j) + i) * 4
//                print("pixelInfo: \(pixelInfo)")
//                if((pixelInfo + 3) < imageData.count){
//                    let red = imageData[pixelInfo]
//                    let green = imageData[pixelInfo+1]
//                    let blue = imageData[pixelInfo+2]
//                    let alpha = imageData[pixelInfo+3]
//                    print("Color = \(pixelInfo), red = \(red), green = \(green) blue = \(blue), alpha = \(alpha)")
//                    let greyColor = Int32((0.3 * Float(red)) + (0.59 * Float(green)) + (0.11 * Float(blue)));
//                    outPtr[i + (j * imageWidth)] = greyColor
//                }
//            }
//        }
//
    
    //}
    
    static func imagePixel(image: UIImage) -> [Int32] {
        let inputCGImage = image.cgImage
        let width = 128//inputCGImage?.width
        let height = 128//inputCGImage?.height
        
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        
        var pixels : [Int32] = [Int32](repeating: 0, count: 128*128)
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext.init(data: &pixels, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorspace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
        
        context?.draw(inputCGImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return pixels
        
    }
    
//    + (UInt32 *) imagePixel:(UIImage *)image
//    {
//    // 1.
//    CGImageRef inputCGImage = [image CGImage];
//    NSUInteger width = CGImageGetWidth(inputCGImage);
//    NSUInteger height = CGImageGetHeight(inputCGImage);
//
//    // 2.
//    NSUInteger bytesPerPixel = 4;
//    NSUInteger bytesPerRow = bytesPerPixel * width;
//    NSUInteger bitsPerComponent = 8;
//
//    //struct pixel * pixels;
//    UInt32 * pixels;
//    pixels = (UInt32 *) calloc(height* width, sizeof(UInt32));
//    //pixels = (struct pixel *) calloc(1, sizeof(struct pixel) * width * height);
//
//    // 3.
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//
//    // 4.
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputCGImage);
//
//    // 5. Cleanup
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//
//
//
//    unsigned long numberOfPixels = width * height;
//    NSMutableArray *temp = [[NSMutableArray alloc] init];
//    for (unsigned i = 0; i < numberOfPixels; i++) {
//    //you can add code here
//    //        NSLog(@"pixels r %c",pixels[i].r);
//    //        NSLog(@"pixels g %c", pixels[i].g);
//    //        NSLog(@"pixels b %c",pixels[i].b);
//
//    //pixels[i].b;
//    //[temp insertObject:pixels[i] atIndex:i];
//    }
//
//    return pixels;
//
//
//
//    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //
//    //    CGImageRef imageRef = image.CGImage;
//    //
//    //    size_t width = CGImageGetWidth(imageRef);
//    //    size_t height = CGImageGetHeight(imageRef);
//    //
//    //    struct pixel *pixels = (struct pixel *) calloc(1, sizeof(struct pixel) * width * height);
//    //
//    //
//    //    size_t bytesPerComponent = 8;
//    //    size_t bytesPerRow = width * sizeof(struct pixel);
//    //
//    //    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bytesPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    //
//    //    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
//    //    unsigned long numberOfPixels = width * height;
//    //
//    //    if (context != NULL) {
//    //        for (unsigned i = 0; i < numberOfPixels; i++) {
//    //            //you can add code here
//    //            NSLog(@"pixels r %c",pixels[i].r);
//    //            NSLog(@"pixels g %c", pixels[i].g);
//    //            NSLog(@"pixels b %c",pixels[i].b);
//    //
//    //            //pixels[i].b;
//    //        }
//    //
//    //
//    //        free(pixels);
//    //        CGContextRelease(context);
//    //    }
//
//    CGColorSpaceRelease(colorSpace);
//
//    }
    
    static func BlurGreyMedian(_ pixels: inout [Int8]) {
        var arr: [Int8] = [Int8](repeating:0, count:9)
        let w = imageWidth
        for j in (1...imageHeight - 2).reversed() {
            for i in (1...imageWidth - 2).reversed() {
                arr[0] = pixels[(i-1) + ((j-1) * w)]
                arr[1] = pixels[i + ((j - 1) * w)]
                arr[2] = pixels[(i + 1) + ((j - 1) * w)]

                arr[3] = pixels[(i-1) + (j * w)]
                arr[4] = pixels[i + (j * w)]
                arr[5] = pixels[(i + 1) + (j * w)]


                arr[6] = pixels[(i-1) + ((j + 1) * w)]
                arr[7] = pixels[i + ((j + 1) * w)]
                arr[8] = pixels[(i + 1) + ((j + 1) * w)]

                arr.sort()
                pixels[i + (j * w)] = arr[4];
            }
        }
    }

   
    static func getAverageColor(_ pixels: [Int8]) -> Int32 {
        let h = imageHeight;
        let w = imageWidth;
        var red : Int32 = 0
        
        for j in (0...h-1).reversed() {
            for i in (0...w-1).reversed() {
                let byte = pixels[i + j * w]
                red = red + Int32(byte)
        
            }
        }
        return Int32(red / Int32(pixels.count))
    }
    
    
    private static func decomposeArray(_ waveArray: inout [Double]) {
        var h = 128;
        var newWaveArray: [Double] = [Double](repeating: 0.0, count:128);
        for i in 0...127{
            waveArray[i] = waveArray[i] / sqrt(128);
        }
        while h > 1 {
            h = h / 2;
            for i in 0...h-1 {
                newWaveArray[i] = (waveArray[2 * i] + waveArray[(2 * i) + 1]) / sqrt(2);
                newWaveArray[h + i] = (waveArray[2 * i] - waveArray[(2 * i) + 1]) / sqrt(2);
            }
            for i in 0...waveArray.count - 1 {
                waveArray[i] = newWaveArray[i]
            }
        }
    }
    
    private static func transposeMatrix( _ input: inout [[Double]]) {
        for i in 0...127 {
            for j in i...127 {
                if i==j {
                    continue;
                }
                let temp = input[i][j];
                input[i][j] = input[j][i]
                input[j][i] = temp
            }
        }
    }
    
    private static func decomposeImage(_ imageArray: inout [[Double]]) {
        
        //decompose rows
        for i in 0...127 {
            decomposeArray(&imageArray[i]);
        }
        
        //perform a matrix transpose
        transposeMatrix(&imageArray)
        
        //decompose col
        for i in 0...127 {
            decomposeArray(&imageArray[i]);
        }
//
//        // transpose back matrix
        transposeMatrix(&imageArray)
    }
    
    private static func hideUnsignedCoeff(_ waveLetArray: inout [[Double]]) {
        var l = 0;
        var coeff : [Double] = [Double](repeating: 0.0, count:16384);
        var k = 0;
        for i in 0...127 {
            for j in 0...127 {
                if (i == 0 && j == 0) {
                    coeff[k] = 0;
                } else {
                    coeff[k] = abs(waveLetArray[i][j]);
                }
                k = k + 1
            }
        }
        coeff.sort()
        
        k = 0;
        for i in 0...127 {
            for j in 0...127 {
                //if (abs(waveLetArray[i][j]) > coeff[16383 - WaveletCoefsNumber] && i != 0 && j != 0) {
                if (abs(waveLetArray[i][j]) > coeff[16383-WaveletCoefsNumber] && (i != 0 || j != 0)) {
                    if (waveLetArray[i][j] > 0) {
                        waveLetArray[i][j] = 1;
                    } else {
                        waveLetArray[i][j] = -1;
                    }
                    l = l+1
                } else {
                    waveLetArray[i][j] = 0;
                }
            }
        }
        k = k + l;
    }
    
    
    static func getWaveLetMatrix(_ pixels: [Int8], _ WaveletCoefs: inout [[Double]], _ averageColor: Int32) {
        let w = 128;
        
        for i in 0...127 {
            for j in 0...127 {
                let pixelValue = pixels[i + j * w]
                let pixel32 = Int32(pixelValue)
                WaveletCoefs[j][i] = Double(pixel32 - averageColor);
            }
        }
        
        self.decomposeImage(&WaveletCoefs);
        self.hideUnsignedCoeff(&WaveletCoefs);
    }
    
    static func getWaveletCoeffs(_ waveletCoeff: inout [[Double]], _ positiveCoeff: inout [TWaveletPoint], _ negativeCoeff :inout [TWaveletPoint]) {
        var k_pos, k_neg : Int
        for i in 0...WaveletCoefsNumber-1 {
            positiveCoeff[i].X = 0;
            positiveCoeff[i].Y = 0;
            
            negativeCoeff[i].X = 0;
            negativeCoeff[i].Y = 0;
        }
        
        k_neg = 0;
        k_pos = 0;
        
        for i in 0...127 {
            for j in 0...127 {
                if (waveletCoeff[i][j] > 0 && k_pos < WaveletCoefsNumber) {
                    positiveCoeff[k_pos].X = i;
                    positiveCoeff[k_pos].Y = j;
                    k_pos = k_pos + 1;
                } else if (waveletCoeff[i][j] < 0 && k_neg < WaveletCoefsNumber) {
                    negativeCoeff[k_neg].X = i;
                    negativeCoeff[k_neg].Y = j;
                    k_neg = k_neg + 1;
                }
            }
        }
    }
    
    static func getSimilarity(_ waveletCoeffA: [[Double]], _ postiveCoeffB: [TWaveletPoint],
                              _ negativeCoeffB: [TWaveletPoint])-> Double {
        var result = 0.0;
        for k in 0...WaveletCoefsNumber-1 {
            if (waveletCoeffA[postiveCoeffB[k].X][postiveCoeffB[k].Y] > 0 &&
                (postiveCoeffB[k].X > 0 || postiveCoeffB[k].Y > 0)) {
                result += 1;
            }
        }
        
        for k in 0...WaveletCoefsNumber-1 {
            if (waveletCoeffA[negativeCoeffB[k].X][negativeCoeffB[k].Y] < 0 &&
                (negativeCoeffB[k].X > 0 || negativeCoeffB[k].Y > 0)) {
                result += 1;
            }
        }
        //Log.e("SimilaritResult", " Similarity = " + result);
        //print("result = \(result)")
        result = (result * 100.0) / Double(WaveletCoefsNumber);
       // print("result = \(result)")
        return result;
    }
}
