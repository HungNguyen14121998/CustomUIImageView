# CustomUIImageView
---

Ứng dụng cho phép người dùng điền họ tên vào và hệ thống sẽ lấy chữ viết hoa đầu tiên và cuối cùng trong tên của người dùng ví dụ: Nguyễn Hửu Hùng -> NH và sẽ chuyển về dạng hình ảnh với một màu nền và màu chữ ngẫu nhiên

### Hướng dẫn

Người dùng nhập tên vào textField ở phía trên sau đó nhấn enter, hệ thống sẽ chuyển thành ảnh ở giữa màn hình

Người dùng cũng có thể nhấn nút Upload Image để tải ảnh từ trong máy của của họ lên

##### Hàm khởi tạo đối tượng

```swift
init(name: String, image: UIImage?, color: UIColor) {
        var initializationImage = UIImage()
        if image != nil {
            initializationImage = image!
        }
        else {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
            initializationImage = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                let font = UIFont(name: "HelveticaNeue-Medium", size: 100)!
                let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: color]
                let string = name
                let cgRect = CGRect(x: 0, y: 40, width: 200, height: 200)
                string.draw(with: cgRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            }
        }
        
        super.init(image: initializationImage)
    }
```

##### Khai báo đối tượng

```swift
let profileImage = SwiftyAvatar(name: name, image: image, color: darkerBackgroundColors[indexColor])
```

### Tài liệu tham khảo
[SwiftyAvatar](https://github.com/dkalaitzidis/SwiftyAvatar)



