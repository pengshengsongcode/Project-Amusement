#import <UIKit/UIKit.h>

typedef enum {
    PSSTopicTypeAll = 1,
    PSSTopicTypePicture = 10,
    PSSTopicTypeWord = 29,
    PSSTopicTypeVoice = 31,
    PSSTopicTypeVideo = 41
} PSSTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const PSSTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const PSSTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const PSSTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const PSSTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const PSSTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const PSSTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const PSSTopicCellPictureBreakH;