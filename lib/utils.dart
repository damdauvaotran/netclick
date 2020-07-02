String truncateWithEllipsis(String myString, {cutoff = 40}) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
