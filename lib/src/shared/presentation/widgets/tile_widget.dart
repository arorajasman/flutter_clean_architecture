import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/shared/presentation/widgets/circle_image_widget.dart';

/// Widget to build a list tile
class TileWidget extends StatelessWidget {
  /// property to check what type of image the user is passing
  final bool isLocalImage;

  /// property to check if the image is coming from internet or api
  final bool isNetworkImage;

  /// property to get image path
  ///
  /// local image path if value of isLocalImage is true else network
  /// image url if the value of isLocalImage is false
  final String image;

  /// property to check if the user is passing an icon or image
  /// for icon value is true
  final bool isIcon;

  /// property to get the icon
  ///
  /// icon will only be there if the value of isIcon is true
  final IconData icon;

  /// property to get the title for tile
  final String title;

  /// property to get subtitle text
  final String subtitle;

  /// property to get the trailing text
  final String trailingText;

  /// property to get the trailing subtitle
  final String trailingSubtitle;

  final void Function() onTapHandler;

  const TileWidget({
    super.key,
    // TODO: add assertion for
    //the code below that
    //user cannot provide bot the values as true
    required this.isLocalImage,
    required this.isIcon,
    required this.image,
    required this.isNetworkImage,
    required this.title,
    required this.onTapHandler,
    this.subtitle = '',
    this.trailingText = '',
    this.trailingSubtitle = '',
    this.icon = Icons.add,
  });
  // : assert(!(isLocalImage && isNetworkImage),
  // 'Both isLocalImage and isNetworkImage cannot be true at the same time.');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: GestureDetector(
        onTap: onTapHandler,
        child: Container(
          decoration: _tileDecoration(),
          height: MediaQuery.of(context).size.height * 0.12,
          child: _buildTileBody(context),
        ),
      ),
    );
  }

  /// Method to build body of tile
  Row _buildTileBody(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: MediaQuery.of(context).size.width * 0.04,
            ),
            child: CircleImageWidget(leadingImage: image),
          ),
          Expanded(child: _buildTitleUI(context)),
          _buildTrailingUI(context),
        ],
      );

  /// Method to build the title of the tile
  Widget _buildTitleUI(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TODO: need to use the Common title widget
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildSubtitleUI(context),
        ],
      );

  /// Method to build the trailing part of tile
  Widget _buildTrailingUI(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: need to use the Common title widget
            if (trailingText.isNotEmpty || trailingText != '')
              Text(
                trailingText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // TODO: need to use the Common title widget
            if (trailingSubtitle.isNotEmpty || trailingSubtitle != '')
              Text(
                trailingSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      );

  /// Method to build subtitle of tile
  Row _buildSubtitleUI(BuildContext context) => Row(
        children: <Widget>[
          // TODO: need to use the Common title widget
          if (subtitle.isNotEmpty || subtitle != '')
            Container(
              width: MediaQuery.of(context).size.width * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.deepPurpleAccent.shade100,
              ),
              padding: const EdgeInsets.all(6.0),
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      );

  /// Method to create a decoration for the tile
  BoxDecoration _tileDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1.0,
          color: Colors.blueGrey.shade100,
        ),
      ),
    );
  }
}
