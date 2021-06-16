import UIKit

@IBDesignable
class BaseView: UIView {
    
    var contentView:UIView?
    @IBInspectable var nibName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibSetup()
    }
    
    private func xibSetup() {
        guard let view = self.loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        self.contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        guard let nibName = self.nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.xibSetup()
        self.contentView?.prepareForInterfaceBuilder()
    }
}

